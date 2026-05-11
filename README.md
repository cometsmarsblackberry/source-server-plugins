# Source Server Plugins

Shared SourceMod plugin packs for Source dedicated server images.

This repo is meant to keep reusable plugin files out of each individual game
server image repo. Game repos can consume one or more built overlays:

```text
source-common      generic SourceMod plugins for most Source games
source-anticheat   optional anti-cheat packs, not forced into every game
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

scripts/build-pack.sh
  Builds a merged overlay under dist/<pack>/overlay.
```

## Build A Pack

```sh
scripts/validate.sh
scripts/build-pack.sh source-common
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

- Prefer fetching durable GitHub release assets in Actions.
- Compile source-only plugins in Actions once their include dependencies are known.
- Vendor manual AlliedMods downloads or expiring artifacts with a checksum.
- Keep optional policy choices, especially anti-cheat plugins, in separate packs.
