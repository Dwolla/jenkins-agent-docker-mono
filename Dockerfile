ARG CORE_TAG

FROM dwolla/jenkins-agent-core:$CORE_TAG
LABEL maintainer="Dwolla Dev <dev+jenkins-mono@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-mono"

ENV MONO_VERSION=6.12

USER root

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF A6A19B38D3D831EF 04EE7237B7D453EC 648ACFD622F3D138 0E98404D386FA1D9 EF0F382A1A7B6500
RUN echo "deb https://download.mono-project.com/repo/debian/ buster/snapshots/6.12 main" > /etc/apt/sources.list.d/mono-xamarin.list

# Needed for the libgnomeui-0 package.
RUN echo "deb http://deb.debian.org/debian stretch main" > /etc/apt/sources.list.d/stretch.list

# The wheezy/snapshots/4.0.0 repo is signed with a SHA1 hash, which by default is no longer supported by apt.
RUN apt-get -o APT::Hashes::SHA1::Weak=yes -o APT::Hashes::RIPE-MD/160::Weak=yes update

RUN apt-get install -y libgnomeui-0 libgdiplus \
  && apt-get install --allow-remove-essential -y -t buster libmono-corlib4.5-cil \
  && apt-get install -y -t buster mono-devel nuget \
  && rm -rf /var/lib/apt/lists/*

USER jenkins
