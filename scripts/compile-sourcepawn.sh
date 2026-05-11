#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <pack-file> <output-overlay-dir>" >&2
}

if [[ $# -ne 2 ]]; then
  usage
  exit 2
fi

pack_file="$1"
overlay_dir="$2"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="${repo_root}/catalog/sourcepawn-builds.tsv"

if [[ ! -f "${pack_file}" ]]; then
  echo "Pack file not found: ${pack_file}" >&2
  exit 1
fi

if [[ ! -d "${overlay_dir}" ]]; then
  echo "Output overlay dir not found: ${overlay_dir}" >&2
  exit 1
fi

declare -A active_plugins=()

while IFS= read -r line || [[ -n "${line}" ]]; do
  line="${line%%#*}"
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"
  [[ -z "${line}" ]] && continue
  active_plugins["${line}"]=1
done < "${pack_file}"

tasks=()

while IFS=$'\t' read -r plugin_dir source_rel output_rel || [[ -n "${plugin_dir:-}" ]]; do
  [[ -z "${plugin_dir:-}" || "${plugin_dir:0:1}" == "#" ]] && continue

  if [[ -z "${active_plugins[${plugin_dir}]:-}" ]]; then
    continue
  fi

  tasks+=("${plugin_dir}"$'\t'"${source_rel}"$'\t'"${output_rel}")
done < "${manifest}"

if [[ "${#tasks[@]}" -eq 0 ]]; then
  exit 0
fi

sourcemod_root="$("${repo_root}/scripts/setup-sourcemod.sh")"
spcomp="${sourcemod_root}/addons/sourcemod/scripting/spcomp"
compiler_include="${sourcemod_root}/addons/sourcemod/scripting/include"
pack_scripting="${overlay_dir}/addons/sourcemod/scripting"
pack_include="${pack_scripting}/include"

compiled=0

for task in "${tasks[@]}"; do
  IFS=$'\t' read -r plugin_dir source_rel output_rel <<< "${task}"
  source_path="${pack_scripting}/${source_rel}"
  output_path="${overlay_dir}/addons/sourcemod/plugins/${output_rel}"

  if [[ ! -f "${source_path}" ]]; then
    echo "SourcePawn source not found for ${plugin_dir}: ${source_path}" >&2
    exit 1
  fi

  mkdir -p "$(dirname "${output_path}")"
  echo "Compiling ${source_rel} -> addons/sourcemod/plugins/${output_rel}"
  (
    cd "${pack_scripting}"
    "${spcomp}" \
      "${source_rel}" \
      "-i${compiler_include}" \
      "-i${pack_include}" \
      "-i${pack_scripting}" \
      "-o${output_path}"
  )
  compiled=$((compiled + 1))
done

echo "Compiled ${compiled} SourcePawn plugin(s)"
