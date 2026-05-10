#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <pack-name> [output-dir]" >&2
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage
  exit 2
fi

pack="$1"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
pack_file="${repo_root}/packs/${pack}.list"
out_dir="${2:-${repo_root}/dist/${pack}}"
overlay_dir="${out_dir}/overlay"
inventory="${out_dir}/inventory.txt"

if [[ ! -f "${pack_file}" ]]; then
  echo "Pack file not found: ${pack_file}" >&2
  exit 1
fi

rm -rf "${out_dir}"
mkdir -p "${overlay_dir}"

{
  echo "pack=${pack}"
  echo "built_at_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo
  echo "plugins:"
} > "${inventory}"

while IFS= read -r line || [[ -n "${line}" ]]; do
  line="${line%%#*}"
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"
  [[ -z "${line}" ]] && continue

  plugin_dir="${repo_root}/${line}"
  plugin_overlay="${plugin_dir}/overlay"

  if [[ ! -d "${plugin_overlay}" ]]; then
    echo "Missing overlay for pack entry: ${line}" >&2
    exit 1
  fi

  if ! find "${plugin_overlay}" -type f -print -quit | grep -q .; then
    echo "Overlay has no files: ${line}" >&2
    exit 1
  fi

  cp -a "${plugin_overlay}/." "${overlay_dir}/"
  echo "- ${line}" >> "${inventory}"
done < "${pack_file}"

echo "Built ${pack} -> ${overlay_dir}"

