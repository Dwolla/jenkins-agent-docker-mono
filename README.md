# Jenkins Agent with mono

[![](https://images.microbadger.com/badges/image/dwolla/jenkins-agent-mono.svg)](https://microbadger.com/images/dwolla/jenkins-agent-mono)
[![license](https://img.shields.io/github/license/dwolla/jenkins-agent-docker-mono.svg?style=flat-square)](https://github.com/Dwolla/jenkins-agent-docker-mono/blob/master/LICENSE)

Docker image based on Dwolla’s [core Jenkins Agent](https://github.com/Dwolla/jenkins-agent-docker-core) images, making [mono](https://www.mono-project.com/) available to Jenkins jobs.

## Local Development

With [yq](https://kislyuk.github.io/yq/) installed, to build this image locally run the following command:

`make CORE_JDK11_TAG=$(curl --silent https://raw.githubusercontent.com/Dwolla/jenkins-agents-workflow/main/.github/workflows/build-docker-image.yml | yq -r .on.workflow_call.inputs.CORE_TAG.default) all`

Alternatively, without [yq](https://kislyuk.github.io/yq/) installed, refer to the CORE_TAG default value(s) defined in [jenkins-agents-workflow](https://github.com/Dwolla/jenkins-agents-workflow/blob/main/.github/workflows/build-docker-image.yml) and run the following command:

`make CORE_JDK11_TAG=<default-core-tag-from-jenkins-agents-workflow> all`
