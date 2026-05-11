# syntax=docker/dockerfile:1.7

FROM debian:bookworm-slim AS build

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      bash \
      ca-certificates \
      coreutils \
      curl \
      findutils \
      grep \
      lib32stdc++6 \
      tar \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . .

RUN scripts/validate.sh \
    && scripts/build-pack.sh source-common \
    && scripts/build-pack.sh source-anticheat-lilac \
    && scripts/build-pack.sh source-admin-sourcebans \
    && scripts/build-pack.sh l4d-common \
    && scripts/build-pack.sh l4d2 \
    && scripts/build-pack.sh l4d-play

FROM scratch

COPY --from=build /src/dist/ /dist/
