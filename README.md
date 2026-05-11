# Source Server Plugins

Shared SourceMod plugin packs for Source dedicated server images.

This repo is meant to keep reusable plugin files out of each individual game
server image repo. Game repos can consume one or more built overlays:

```text
source-common      generic SourceMod plugins for most Source games
source-anticheat-lilac
                   optional LILAC anti-cheat pack
source-admin-sourcebans
                   optional SourceBans++ admin/database pack
l4d-common         L4D-family extensions/plugins shared by L4D images
l4d2               L4D2-only additions that are unsafe for L4D1
l4d-play           L4D-family gameplay/admin plugins for the play image
```

## Layout

```text
plugins/<group>/<plugin>/overlay/
  Files laid out exactly as they should land in the game directory.

packs/<name>.list
  Ordered list of plugin overlay directories to merge into a pack.

catalog/plugins.yml
  Human-readable source, checksum, and status notes.

catalog/sourcepawn-builds.tsv
  SourcePawn files compiled into runtime .smx artifacts during pack builds.

scripts/setup-sourcemod.sh
  Downloads the pinned SourceMod compiler used for SourcePawn builds.

scripts/build-pack.sh
  Builds a merged overlay under dist/<pack>/overlay and compiles SourcePawn
  plugins listed in catalog/sourcepawn-builds.tsv.
```

## Build A Pack

SourcePawn plugins are compiled during `scripts/build-pack.sh` with SourceMod
`1.12.0.7230`. The compiler is downloaded into `.tools/` unless `SOURCEMOD_HOME`
points at an existing SourceMod install.

```sh
scripts/validate.sh
scripts/build-pack.sh source-common
scripts/build-pack.sh source-anticheat-lilac
scripts/build-pack.sh source-admin-sourcebans
scripts/build-pack.sh l4d-common
scripts/build-pack.sh l4d2
scripts/build-pack.sh l4d-play
```

The resulting overlay can be copied into a game image:

```dockerfile
COPY --from=plugin_pack /dist/source-common/overlay/ /opt/l4d/left4dead/
```

## Build The Pack Image

The Docker image contains the generated `dist/` directory only. Game server
image repos can copy overlays from it without vendoring this repository.

```sh
docker build -t ghcr.io/cometsmarsblackberry/source-server-plugins:local .
```

Example game image usage:

```dockerfile
ARG PLUGIN_PACK_IMAGE="ghcr.io/cometsmarsblackberry/source-server-plugins:latest"
FROM ${PLUGIN_PACK_IMAGE} AS plugin-packs

COPY --from=plugin-packs /dist/source-common/overlay/ /path/to/game/
```

## Policy

- Prefer source plus a pinned compiler for SourcePawn plugins.
- Fetch durable GitHub release assets in Actions for non-SourcePawn binaries.
- Vendor manual AlliedMods downloads, expiring artifacts, or binary-only plugins with a checksum.
- Keep optional policy choices, especially anti-cheat plugins, in separate packs.
