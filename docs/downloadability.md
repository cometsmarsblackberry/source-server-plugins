# Downloadability Check

Checked on 2026-05-10. SourceTV Manager was added and checked on 2026-05-11.

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
| SourceTV Manager | `sourcetvmanager.zip` | Manual/local zip. Upstream has nightly build links, but GitHub Actions artifacts can expire. |
| Vocalize Admin Commands | `vocalizeadmincommands.zip` | Forum zip attachment; forum fetch returned 403 from plain `curl`. |
| Scene Processor | `sceneprocessor.zip` | Forum zip attachment; forum fetch returned 403 from plain `curl`. |
| L4D2 Level Changing | `l4d2_levelchanging.zip` | Forum zip attachment; also uses ZIP compression unsupported by older `unzip`; `bsdtar` works. |
| Respawn Improved | `Respawn.zip` | Forum zip attachment; forum fetch returned 403 from plain `curl`. |

## Related Non-Downloaded Items

| Plugin | Fetch method | Notes |
| --- | --- | --- |
| LILAC | GitHub release tarball | Imported into `source-anticheat-lilac` from `sm-plugin-lilac-latest.tar.gz`, SHA-256 `b33503bb668f4104533932951c596474ca2b747d794e5896b10f3870d58eee7c`. |
| SourceBans++ plugins | GitHub release tarball | Imported into `source-admin-sourcebans` from `sourcebans-pp-Plugins-Latest.tar.gz`, SHA-256 `18fbd458af0b610f93553a8eaec1c89d1cc6bca8b2a94cbd4ecc73f4c88aabce`. |
