ARG CORE_TAG

FROM dwolla/jenkins-agent-core:$CORE_TAG

LABEL maintainer="Dwolla Dev <dev+jenkins-mono@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-docker-mono"

USER root

# install thrift compiler
RUN apt install -y wget
RUN cd /tmp && wget https://launchpad.net/ubuntu/+archive/primary/+files/thrift-compiler_0.9.1-2.1_amd64.deb
RUN dpkg -i /tmp/thrift-compiler_0.9.1-2.1_amd64.deb
RUN rm /tmp/thrift-compiler_0.9.1-2.1_amd64.deb && apt remove -y wget

# install ruby
RUN apt install -y ruby ruby-dev
RUN gem install bundler
RUN chown -R jenkins /var/lib/gems/2.7.0/

# add repository and install mono
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF A6A19B38D3D831EF 04EE7237B7D453EC 648ACFD622F3D138 0E98404D386FA1D9 EF0F382A1A7B6500
RUN echo "deb https://download.mono-project.com/repo/debian/ buster/snapshots/6.12 main" > /etc/apt/sources.list.d/mono-xamarin.list
RUN apt update && apt install -y mono-devel

# install nuget
RUN apt install -y nuget

USER jenkins
