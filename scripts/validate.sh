#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
errors=0

for pack_file in "${repo_root}"/packs/*.list; do
  pack_name="$(basename "${pack_file}" .list)"
  seen_entries=0

  while IFS= read -r line || [[ -n "${line}" ]]; do
    line="${line%%#*}"
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [[ -z "${line}" ]] && continue

    seen_entries=$((seen_entries + 1))
    plugin_dir="${repo_root}/${line}"
    plugin_overlay="${plugin_dir}/overlay"

    if [[ ! -d "${plugin_dir}" ]]; then
      echo "ERROR: ${pack_name}: missing plugin dir: ${line}" >&2
      errors=$((errors + 1))
      continue
    fi

    if [[ ! -d "${plugin_overlay}" ]]; then
      echo "ERROR: ${pack_name}: missing overlay dir: ${line}/overlay" >&2
      errors=$((errors + 1))
      continue
    fi

    if ! find "${plugin_overlay}" -type f -print -quit | grep -q .; then
      echo "ERROR: ${pack_name}: overlay has no files: ${line}" >&2
      errors=$((errors + 1))
    fi

    while IFS= read -r top; do
      base="$(basename "${top}")"
      case "${base}" in
        addons|cfg) ;;
        *)
          echo "ERROR: ${pack_name}: unexpected overlay root '${base}' in ${line}" >&2
          errors=$((errors + 1))
          ;;
      esac
    done < <(find "${plugin_overlay}" -mindepth 1 -maxdepth 1 -type d -print)
  done < "${pack_file}"

  if [[ "${seen_entries}" -eq 0 ]]; then
    echo "WARN: ${pack_name}: pack has no active entries" >&2
  fi
done

if [[ "${errors}" -ne 0 ]]; then
  exit 1
fi

echo "Validation passed"

