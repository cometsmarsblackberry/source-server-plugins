# Downloadability Check

Checked on 2026-05-10. SourceTV Manager was added and checked on 2026-05-11.
SourcePawn source-build conversion was added on 2026-05-11.

## Source-Built In This Repo

The pack build downloads pinned SourceMod `1.12.0.7230` from the official
GitHub release and compiles the entries listed in `catalog/sourcepawn-builds.tsv`
into `dist/`. Generated `.smx` files are not committed for these plugins.

| Plugin | Build input | Notes |
| --- | --- | --- |
| SM-Re.LoadMap | GitHub source | Commit `4ec12323ed78e19dbc402232d5c934b6f6f57462`. |
| Tickrate | Manually downloaded source | Imported from `~/Downloads/tickrate.sp`; now compiled during the pack build. |
| Spray Exploit Fixer | GitHub source | Commit `56601c6a838c008c5ee2cd6540d3c2f24bd58682`. |
| Command Buffer | GitHub source + gamedata | Commit `19e513731f38adaeb79ca41efda2feb6114a2fbb`. |
| Dev Cmds | GitHub source | Source declares version `1.54`; old fallback binary URL remains in the catalog for reference. |
| No Auto Kick | GitHub source | sapphonie/gameservers commit `3407bb856fc3a34e7e28e7afebb82c7683378e7c`. |
| Fun Commands X | GitHub source | Commit `ec45781ab20152f1bac0debaa92eb1f54998962b`; upstream `scipting` folder is normalized to `scripting`. |
| Fire Bullets Fix | GitHub source + gamedata | Commit `19f9f058c97a0175d80028883a0aa7eca805012c`. |
| Console Welcome | Manually downloaded source | Imported from `~/Downloads/console-welcome.sp`; now compiled during the pack build. |
| ChatExec | GitHub source + translations | Commit `61e45b9d3b4207ab92b40c8b8266bb0404a3c196`. |
| AutoReload | Vendored source from forum zip | Forum fetch returned 403 from plain `curl`, but the source compiles locally. |
| Vocalize Admin Commands | Vendored source from forum zip | Compiles against vendored Scene Processor include. |
| Scene Processor | Vendored source from forum zip | Source and include are vendored. |
| Respawn Improved | Vendored source from forum zip | Source, include, translation, and gamedata are vendored. |
| l4d2pause | GitHub source | Uses vendored Multi Colors include. |
| l4d2_vote_manager3 | GitHub source | Uses vendored Multi Colors and BuiltinVotes includes. |
| savechat | GitHub source | Commit `4bd13cd73316171007ccad3afa1a6ec4caaa552d`. |
| admin_hp | GitHub source | Uses vendored Multi Colors include. |
| l4d_console_spam | GitHub source + gamedata | SirPlease/L4D2-Competitive-Rework commit `e7f72380991eefe58abc132d9fd18ce2e5595dea`. |
| sp_public selected plugins | Vendored source/includes from old Actions artifact | `autorecorder`, `hide_sourcetv`, and `placeholders` now compile during the pack build. |
| ragdoll_options | GitHub source + include | Source and `neb_stocks.inc` are from commit `08f0772871f12f20136bfd063f6de37be17c3b73`. |
| L4D2 Level Changing | Vendored source from forum zip | Source, include, and gamedata are vendored. |
| LILAC | GitHub source + translations | Commit `4d6a8ba83d5af07abafc707ee714161c04474951`. |
| SourceBans++ plugins | GitHub source + configs/translations | Commit `48f011c1e3395d024cc6a23d9cbf4fb69672424f`. |

## Keep Vendored For Now

These remaining runtime binaries are either not SourcePawn plugins, do not have
identified source, or are otherwise awkward to fetch and rebuild reproducibly.

| Plugin | Current local artifact | Reason |
| --- | --- | --- |
| SourceTV Manager | `sourcetvmanager.zip` | Manual/local zip. Upstream has nightly build links, but GitHub Actions artifacts can expire. |
| BuiltinVotes | `builtinvotes-sm1.12-linux-93e0b8c.zip` | Extension binaries from GitHub Actions artifact. |

## Related Non-Downloaded Items

| Plugin | Fetch method | Notes |
| --- | --- | --- |
| Multi Colors | GitHub release zip | Vendored as a compile-time include dependency, not a runtime plugin. |
