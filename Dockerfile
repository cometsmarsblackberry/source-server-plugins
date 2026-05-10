# syntax=docker/dockerfile:1.7

FROM alpine:3.20 AS build

RUN apk add --no-cache bash coreutils findutils grep

WORKDIR /src
COPY . .

RUN scripts/validate.sh \
    && scripts/build-pack.sh source-common \
    && scripts/build-pack.sh l4d-common \
    && scripts/build-pack.sh l4d-play

FROM scratch

COPY --from=build /src/dist/ /dist/

