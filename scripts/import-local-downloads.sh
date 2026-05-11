#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="${DOWNLOADS_DIR:-${HOME}/Downloads/plugins}"

require_file() {
  local file="$1"
  if [[ ! -f "${src}/${file}" ]]; then
    echo "Missing ${src}/${file}" >&2
    exit 1
  fi
}

for file in \
  AutoReload.zip \
  Respawn.zip \
  builtinvotes-sm1.12-linux-93e0b8c.zip \
  command_buffer.games.txt \
  command_buffer.smx \
  console-welcome.smx \
  l4d2_levelchanging.zip \
  sceneprocessor.zip \
  sm_dev_cmds.smx \
  sourcetvmanager.zip \
  sp_public-sm1.12-0b7f52e.zip \
  spray_exploit_fixer.smx \
  tickrate.smx \
  vocalizeadmincommands.zip; do
  require_file "${file}"
done

rm -rf "${repo_root}/plugins"
mkdir -p \
  "${repo_root}/plugins/source-common/tickrate/overlay/addons/sourcemod/plugins" \
  "${repo_root}/plugins/source-common/spray-exploit-fixer/overlay/addons/sourcemod/plugins" \
  "${repo_root}/plugins/source-common/command-buffer/overlay/addons/sourcemod/plugins" \
  "${repo_root}/plugins/source-common/command-buffer/overlay/addons/sourcemod/gamedata" \
  "${repo_root}/plugins/source-common/sm-dev-cmds/overlay/addons/sourcemod/plugins" \
  "${repo_root}/plugins/source-common/console-welcome/overlay/addons/sourcemod/plugins" \
  "${repo_root}/plugins/source-common/autoreload/overlay/addons/sourcemod" \
  "${repo_root}/plugins/source-common/sourcetvmanager/overlay" \
  "${repo_root}/plugins/l4d-play/vocalize-admin-commands/overlay" \
  "${repo_root}/plugins/l4d-play/sceneprocessor/overlay" \
  "${repo_root}/plugins/l4d-play/builtinvotes/overlay" \
  "${repo_root}/plugins/l4d-play/respawn/overlay" \
  "${repo_root}/plugins/l4d-play/sp-public-selected/overlay" \
  "${repo_root}/plugins/l4d2/l4d2-levelchanging/overlay"

cp -a "${src}/tickrate.smx" "${repo_root}/plugins/source-common/tickrate/overlay/addons/sourcemod/plugins/tickrate.smx"
cp -a "${src}/spray_exploit_fixer.smx" "${repo_root}/plugins/source-common/spray-exploit-fixer/overlay/addons/sourcemod/plugins/spray_exploit_fixer.smx"
cp -a "${src}/command_buffer.smx" "${repo_root}/plugins/source-common/command-buffer/overlay/addons/sourcemod/plugins/command_buffer.smx"
cp -a "${src}/command_buffer.games.txt" "${repo_root}/plugins/source-common/command-buffer/overlay/addons/sourcemod/gamedata/command_buffer.games.txt"
cp -a "${src}/sm_dev_cmds.smx" "${repo_root}/plugins/source-common/sm-dev-cmds/overlay/addons/sourcemod/plugins/sm_dev_cmds.smx"
cp -a "${src}/console-welcome.smx" "${repo_root}/plugins/source-common/console-welcome/overlay/addons/sourcemod/plugins/console-welcome.smx"

work="$(mktemp -d)"
trap 'rm -rf "${work}"' EXIT

unzip -q "${src}/AutoReload.zip" -d "${work}/autoreload"
cp -a "${work}/autoreload/plugins" "${repo_root}/plugins/source-common/autoreload/overlay/addons/sourcemod/"
cp -a "${work}/autoreload/scripting" "${repo_root}/plugins/source-common/autoreload/overlay/addons/sourcemod/"

unzip -q "${src}/sourcetvmanager.zip" -d "${work}/sourcetvmanager"
cp -a "${work}/sourcetvmanager/addons" "${repo_root}/plugins/source-common/sourcetvmanager/overlay/"

unzip -q "${src}/vocalizeadmincommands.zip" -d "${work}/vocalizeadmincommands"
unzip -q "${src}/sceneprocessor.zip" -d "${work}/sceneprocessor"
unzip -q "${src}/builtinvotes-sm1.12-linux-93e0b8c.zip" -d "${work}/builtinvotes"
mkdir -p "${work}/l4d2_levelchanging"
bsdtar -xf "${src}/l4d2_levelchanging.zip" -C "${work}/l4d2_levelchanging"

cp -a "${work}/vocalizeadmincommands/addons" "${repo_root}/plugins/l4d-play/vocalize-admin-commands/overlay/"
cp -a "${work}/sceneprocessor/addons" "${repo_root}/plugins/l4d-play/sceneprocessor/overlay/"
cp -a "${work}/builtinvotes/addons" "${repo_root}/plugins/l4d-play/builtinvotes/overlay/"
cp -a "${work}/l4d2_levelchanging/addons" "${repo_root}/plugins/l4d2/l4d2-levelchanging/overlay/"

unzip -q "${src}/Respawn.zip" -d "${work}/respawn"
mkdir -p "${repo_root}/plugins/l4d-play/respawn/overlay/addons/sourcemod"
cp -a "${work}/respawn/l4d_sm_respawn/gamedata" "${repo_root}/plugins/l4d-play/respawn/overlay/addons/sourcemod/"
cp -a "${work}/respawn/l4d_sm_respawn/plugins" "${repo_root}/plugins/l4d-play/respawn/overlay/addons/sourcemod/"
cp -a "${work}/respawn/l4d_sm_respawn/scripting" "${repo_root}/plugins/l4d-play/respawn/overlay/addons/sourcemod/"
cp -a "${work}/respawn/l4d_sm_respawn/translations" "${repo_root}/plugins/l4d-play/respawn/overlay/addons/sourcemod/"

unzip -q "${src}/sp_public-sm1.12-0b7f52e.zip" -d "${work}/sp_public"
mkdir -p \
  "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/plugins" \
  "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/scripting"
cp -a "${work}/sp_public/addons/sourcemod/plugins/autorecorder.smx" "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/plugins/"
cp -a "${work}/sp_public/addons/sourcemod/plugins/hide_sourcetv.smx" "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/plugins/"
cp -a "${work}/sp_public/addons/sourcemod/plugins/placeholders.smx" "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/plugins/"
cp -a "${work}/sp_public/addons/sourcemod/scripting/autorecorder.sp" "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/scripting/"
cp -a "${work}/sp_public/addons/sourcemod/scripting/hide_sourcetv.sp" "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/scripting/"
cp -a "${work}/sp_public/addons/sourcemod/scripting/placeholders.sp" "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/scripting/"
cp -a "${work}/sp_public/addons/sourcemod/scripting/include" "${repo_root}/plugins/l4d-play/sp-public-selected/overlay/addons/sourcemod/scripting/"

echo "Imported local downloads from ${src}"
