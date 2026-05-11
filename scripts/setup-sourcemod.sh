#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

version="1.12.0-git7230"
release_tag="1.12.0.7230"
archive="sourcemod-${version}-linux.tar.gz"
url="https://github.com/alliedmodders/sourcemod/releases/download/${release_tag}/${archive}"
sha256="18f1f8e9fcdfe9566378280835489bf77bb821d3c9fd07a582798c1fc39aa215"

if [[ -n "${SOURCEMOD_HOME:-}" ]]; then
  if [[ ! -x "${SOURCEMOD_HOME}/addons/sourcemod/scripting/spcomp" ]]; then
    echo "SOURCEMOD_HOME does not contain executable spcomp: ${SOURCEMOD_HOME}" >&2
    exit 1
  fi
  printf '%s\n' "${SOURCEMOD_HOME}"
  exit 0
fi

tools_dir="${repo_root}/.tools/sourcemod"
target="${tools_dir}/${version}-linux"
spcomp="${target}/addons/sourcemod/scripting/spcomp"

if [[ -x "${spcomp}" ]]; then
  printf '%s\n' "${target}"
  exit 0
fi

mkdir -p "${tools_dir}"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT

curl -fsSL "${url}" -o "${tmp_dir}/${archive}"
printf '%s  %s\n' "${sha256}" "${tmp_dir}/${archive}" | sha256sum -c - >/dev/null

rm -rf "${tmp_dir}/extract" "${target}.tmp"
mkdir -p "${tmp_dir}/extract"
tar -xzf "${tmp_dir}/${archive}" -C "${tmp_dir}/extract"
mv "${tmp_dir}/extract" "${target}.tmp"
chmod +x "${target}.tmp/addons/sourcemod/scripting/spcomp"
rm -rf "${target}"
mv "${target}.tmp" "${target}"

printf '%s\n' "${target}"
