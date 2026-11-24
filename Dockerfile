ARG CORE_TAG

FROM dwolla/jenkins-agent-core:$CORE_TAG

LABEL maintainer="Dwolla Dev <dev+jenkins-mono@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-mono"

USER root

# Mono 6.12 from Debian (the core image is trixie). mono-project.com's own repo stops at buster.
# xbuild compiles with mcs; Debian's Mono has no Roslyn csc. Builds bring their own nuget.exe.
RUN apt-get update \
 && apt-get install -y --no-install-recommends mono-devel mono-xbuild ca-certificates-mono \
 && rm -rf /var/lib/apt/lists/*

USER jenkins
