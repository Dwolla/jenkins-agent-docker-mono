# Jenkins Agent with mono

[![](https://images.microbadger.com/badges/image/dwolla/jenkins-agent-mono.svg)](https://microbadger.com/images/dwolla/jenkins-agent-mono)
[![license](https://img.shields.io/github/license/dwolla/jenkins-agent-docker-mono.svg?style=flat-square)](https://github.com/Dwolla/jenkins-agent-docker-mono/blob/master/LICENSE)

Docker image based on Dwolla’s [core Jenkins Agent](https://github.com/Dwolla/jenkins-agent-docker-core) images, making [mono](https://www.mono-project.com/) available to Jenkins jobs.

## Local Development

To build this image locally, refer to the CORE_TAG default value(s) defined in [jenkins-agents-workflow](https://github.com/Dwolla/jenkins-agents-workflow/blob/main/.github/workflows/build-docker-image.yml) and run the following command:

`make TAG_ENV=<default-core-tag-from-jenkins-agents-workflow> all`
