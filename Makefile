CORE_TAG ?= $(shell curl --silent https://raw.githubusercontent.com/Dwolla/jenkins-agents-workflow/main/.github/workflows/build-docker-image.yml | yq .on.workflow_call.inputs.CORE_TAG.default)

all: build
.PHONY: all build clean

build: Dockerfile
	docker buildx build \
	  --platform linux/amd64 \
	  --build-arg CORE_TAG=${CORE_TAG} \
	  --tag dwolla/jenkins-agent-mono:${CORE_TAG}-SNAPSHOT \
	  .

clean:
	docker image rm --force dwolla/jenkins-agent-mono:${CORE_TAG}-SNAPSHOT
