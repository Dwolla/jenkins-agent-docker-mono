ARG CORE_TAG

FROM dwolla/jenkins-agent-core:$CORE_TAG
LABEL maintainer="Dwolla Dev <dev+jenkins-mono@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-mono"

ENV THRIFT_VERSION=0.9.3

USER root

# install deps for building thrift-compiler
RUN apt update && apt install -y wget libboost-dev libboost-test-dev libboost-program-options-dev libboost-filesystem-dev libboost-thread-dev libevent-dev automake libtool flex bison pkg-config g++

# add repository and install mono
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF A6A19B38D3D831EF 04EE7237B7D453EC 648ACFD622F3D138 0E98404D386FA1D9 EF0F382A1A7B6500
RUN echo "deb https://download.mono-project.com/repo/debian/ buster/snapshots/6.12 main" > /etc/apt/sources.list.d/mono-xamarin.list
RUN apt update && apt install -y mono-devel

# add repository and install libssl1.0-dev, which is needed to build thrift 0.9.3 https://github.com/rvm/rvm/issues/4764
RUN echo "deb http://security.ubuntu.com/ubuntu bionic-security main" > /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
RUN apt update && apt install -y libssl1.0-dev

# build thrift from source
RUN wget -O /tmp/thrift-${THRIFT_VERSION}.tar.gz https://archive.apache.org/dist/thrift/${THRIFT_VERSION}/thrift-${THRIFT_VERSION}.tar.gz
RUN cd /tmp && tar -xvf /tmp/thrift-${THRIFT_VERSION}.tar.gz
RUN cd /tmp/thrift-${THRIFT_VERSION} && ./configure
RUN cd /tmp/thrift-${THRIFT_VERSION} && make
RUN cd /tmp/thrift-${THRIFT_VERSION} && make install

# install nuget
RUN apt install -y nuget

USER jenkins
