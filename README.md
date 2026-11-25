# Jenkins Agent with mono

[![](https://images.microbadger.com/badges/image/dwolla/jenkins-agent-mono.svg)](https://microbadger.com/images/dwolla/jenkins-agent-mono)
[![license](https://img.shields.io/github/license/dwolla/jenkins-agent-docker-mono.svg?style=flat-square)](https://github.com/Dwolla/jenkins-agent-docker-mono/blob/master/LICENSE)

Docker image based on Dwolla’s [core Jenkins Agent](https://github.com/Dwolla/jenkins-agent-docker-core) images, making [mono](https://www.mono-project.com/) available to Jenkins jobs.

## What's in it

- **Mono 6.12** (`mono`, `xbuild`) from Debian trixie, the core image's OS. `xbuild` compiles with `mcs`: Debian's Mono doesn't ship the Roslyn `csc`.
- The Jenkins agent runs on the core image's Java 21.
- `nuget`: NuGet 3.4.3 (`nuget.exe`, pinned by checksum) run through Mono.

## Local Development

With [yq](https://kislyuk.github.io/yq/) installed, `make` builds the image on the shared workflow's default `CORE_TAG`:

```bash
make all
```

Or pass a core tag from [jenkins-agents-workflow](https://github.com/Dwolla/jenkins-agents-workflow/blob/main/.github/workflows/build-docker-image.yml) yourself:

`make CORE_TAG=<core-tag> all`

CI publishes the image for `linux/amd64` only. On Apple silicon, build for arm64 instead: Mono crashes under amd64 emulation, and a cross-built amd64 image ends up without Mono's CA certificate store.

`make PLATFORM=linux/arm64 all`

`make test` (with the same `PLATFORM`) checks that `mono`, `xbuild`, `mcs` and `nuget` are on the `PATH`.
