# Downloadability Check

Checked on 2026-05-10.

## Easy To Fetch In Actions

These should not need to be baked into git long term.

| Plugin | Current local artifact | Fetch method | Notes |
| --- | --- | --- | --- |
| BuiltinVotes | `builtinvotes-sm1.12-linux-93e0b8c.zip` | GitHub Actions artifact API | Public artifact exists and is not expired. Download requires `GITHUB_TOKEN` in Actions. Artifact ID checked: `6214148569`. |
| sp_public selected plugins | `sp_public-sm1.12-0b7f52e.zip` | GitHub Actions artifact API | Public artifact exists and is not expired. Download requires `GITHUB_TOKEN` in Actions. Artifact ID checked: `6214170056`. |
| Dev Cmds fallback binary | `sm_dev_cmds.smx` | SourceMod compiler download | `https://www.sourcemod.net/vbcompiler.php?file_id=180343` downloaded successfully and matched the local SHA-256. Prefer compiling from GitHub source now that the source location is known. |

## Better Compiled In Our Actions

These have GitHub source but no obvious release binary or public Actions artifact.

| Plugin | Current local artifact | Fetch method | Notes |
| --- | --- | --- | --- |
| Spray Exploit Fixer | `spray_exploit_fixer.smx` | Raw GitHub source, then compile | Source file is available at `scripting/spray_exploit_fixer.sp`; no release/assets found. |
| Command Buffer | `command_buffer.smx` + gamedata | Raw GitHub source/gamedata, then compile | Source and gamedata are available from GitHub; no release/assets found. |
| Dev Cmds | `sm_dev_cmds.smx` | Raw GitHub source, then compile | Source file is available at `https://raw.githubusercontent.com/SilvDev/Various_Scripts_Collection/main/sm_dev_cmds.sp`. Current source declares version `1.54`; the local vendored `.smx` is kept until the compile workflow exists. |

## Keep Vendored For Now

These are AlliedMods forum zip/attachment downloads or otherwise awkward to fetch reproducibly.

| Plugin | Current local artifact | Reason |
| --- | --- | --- |
| Tickrate | `tickrate.smx` | AlliedMods/forum download. No verified clean CI URL yet. |
| Console Welcome | `console-welcome.smx` | AlliedMods/forum download. No verified clean CI URL yet. |
| AutoReload | `AutoReload.zip` | Forum zip attachment; forum fetch returned 403 from plain `curl`. |
| Vocalize Admin Commands | `vocalizeadmincommands.zip` | Forum zip attachment; forum fetch returned 403 from plain `curl`. |
| Scene Processor | `sceneprocessor.zip` | Forum zip attachment; forum fetch returned 403 from plain `curl`. |
| L4D2 Level Changing | `l4d2_levelchanging.zip` | Forum zip attachment; also uses ZIP compression unsupported by older `unzip`; `bsdtar` works. |
| Respawn Improved | `Respawn.zip` | Forum zip attachment; forum fetch returned 403 from plain `curl`. |

## Related Non-Downloaded Items

| Plugin | Fetch method | Notes |
| --- | --- | --- |
| LILAC | GitHub release tarball | Latest release asset exists with SHA-256 published by GitHub. Keep in optional anti-cheat pack. |
| SourceBans++ plugins | GitHub release tarball | `Plugins-Latest` release asset exists with SHA-256 published by GitHub. Keep as optional admin integration pack. |
