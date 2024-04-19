ARG CORE_TAG

FROM dwolla/jenkins-agent-core:$CORE_TAG
LABEL maintainer="Dwolla Dev <dev+jenkins-mono@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-mono"

USER root
# install nuget
RUN apt install -y nuget

# add repository and install mono
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF A6A19B38D3D831EF 04EE7237B7D453EC 648ACFD622F3D138 0E98404D386FA1D9 EF0F382A1A7B6500
RUN echo "deb https://download.mono-project.com/repo/debian/ buster/snapshots/6.12 main" > /etc/apt/sources.list.d/mono-xamarin.list
RUN apt update && apt install -y mono-devel

USER jenkins
