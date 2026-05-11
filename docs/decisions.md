# Decisions

## Repos

Use this repo as the shared plugin-pack repo. Keep each game server image in
its own repo, for example `l4d-server`, `l4d2-server`, and `tf2-server`.

Game repos should consume built packs from this repo instead of vendoring the
same generic plugins repeatedly.

## AlliedMods Downloads

AlliedMods forum attachments can sometimes be downloaded if we know the direct
attachment URL, but they are not as pleasant or stable as GitHub releases.

For now, manually downloaded AlliedMods files are vendored as overlays and
their SHA-256 checksums are recorded in `catalog/plugins.yml`.

## GitHub Downloads

Durable GitHub release assets should be downloaded in Actions. Source-only
plugins should be compiled in Actions with a pinned SourceMod compiler once
their include dependencies are listed.

## SourcePawn Builds

SourcePawn plugins should prefer vendored source plus the pinned SourceMod
compiler over committed `.smx` binaries. `scripts/build-pack.sh` compiles the
entries in `catalog/sourcepawn-builds.tsv` into `dist/`; generated `.smx`
artifacts are not committed for those entries.

## LILAC And TF2

Do not put LILAC directly in `source-common` if TF2 will use a different
anti-cheat. Make it an optional pack, such as `source-anticheat-lilac`, and
have L4D images opt into that pack. Removing it in the TF2 Dockerfile would
work, but skipping the pack is cleaner and easier to audit.

## Existing l4d-server Plugins

The existing `l4d-server` plugin/extension files were copied into this repo,
not removed from `l4d-server`.

- `images/l4d-plugins/sourcetvsupport` -> `plugins/l4d-common/sourcetvsupport`
- `images/l4d-plugins/tickrate-enabler` -> `plugins/l4d-common/tickrate-enabler`
- `images/l4d-play/plugins/ragdoll_options.smx` -> `plugins/l4d-play/ragdoll-options`

## L4D2-Only Plugins

Keep plugins that do not support L4D1 in the `l4d2` pack so L4D1 images can
consume `l4d-common` and `l4d-play` without carrying incompatible files.

## SourceBans++

SourceBans++ is broadly SourceMod-compatible, but it is a service integration
that expects database/web configuration. Treat it as an optional admin pack,
not as part of the lowest-level `source-common` pack.

## Optional Packs In L4D Images

The pack repo keeps LILAC and SourceBans++ optional. Individual game image repos
decide whether to opt into them. The L4D image repo currently installs:

- `source-anticheat-lilac` in `l4d-sourcemod`
- `source-admin-sourcebans` in `l4d-play`
