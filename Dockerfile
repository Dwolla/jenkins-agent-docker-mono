FROM dwolla/jenkins-agent-core:debian
LABEL maintainer="Dwolla Dev <dev+jenkins-mono@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-mono"

ENV MONO_VERSION=5.18.0.240+dfsg-3

USER root

RUN apt-get update \
  && apt-get install -y nuget mono-xbuild=${MONO_VERSION} mono-devel=${MONO_VERSION} \
  && rm -rf /var/lib/apt/lists/* /tmp/*

USER jenkins
