ARG CORE_TAG

FROM dwolla/jenkins-agent-core:$CORE_TAG

LABEL maintainer="Dwolla Dev <dev+jenkins-mono@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-mono"

USER root

# Mono 6.12 from Debian (the core image is trixie). mono-project.com's own repo stops at buster.
# xbuild compiles with mcs; Debian's Mono has no Roslyn csc.
RUN apt-get update \
 && apt-get install -y --no-install-recommends mono-devel mono-xbuild ca-certificates-mono \
 && rm -rf /var/lib/apt/lists/*

# A `nuget` command for builds that call it (Debian trixie doesn't package it), pinned by checksum
ADD --checksum=sha256:3b1ea72943968d7af6bacdb4f2f3a048a25afd14564ef1d8b1c041fdb09ebb0a \
    https://dist.nuget.org/win-x86-commandline/v3.4.3/nuget.exe /usr/local/lib/nuget/nuget.exe
RUN chmod 644 /usr/local/lib/nuget/nuget.exe \
 && printf '#!/bin/sh\nexec mono /usr/local/lib/nuget/nuget.exe "$@"\n' > /usr/local/bin/nuget \
 && chmod 755 /usr/local/bin/nuget

USER jenkins
