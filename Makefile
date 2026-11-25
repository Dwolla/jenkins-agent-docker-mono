ifndef CORE_TAG
CORE_TAG := $(shell curl --silent --fail https://raw.githubusercontent.com/Dwolla/jenkins-agents-workflow/main/.github/workflows/build-docker-image.yml | yq -r .on.workflow_call.inputs.CORE_TAG.default)
endif
ifeq ($(filter-out null,$(strip $(CORE_TAG))),)
$(error CORE_TAG is empty: install yq or pass CORE_TAG=<core-tag>)
endif
# CI publishes amd64 only. On Apple silicon use PLATFORM=linux/arm64: Mono crashes under amd64 emulation.
PLATFORM ?= linux/amd64

all: build
.PHONY: all build test clean

build: Dockerfile
	docker buildx build \
	  --load \
	  --platform $(PLATFORM) \
	  --build-arg CORE_TAG=$(CORE_TAG) \
	  --tag dwolla/jenkins-agent-mono:$(CORE_TAG)-SNAPSHOT \
	  .

test: build
	CORE_TAG=$(CORE_TAG) docker compose -f docker-compose.test.yml run --rm --build sut

clean:
	docker image rm --force dwolla/jenkins-agent-mono:$(CORE_TAG)-SNAPSHOT
