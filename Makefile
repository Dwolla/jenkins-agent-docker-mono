CORE_TAGS := $(TAG_ENV)
JOB := core-${CORE_TAG}
CHECK_JOB := check-${CORE_TAG}
CLEAN_JOB := clean-${CORE_TAG}

all: ${CHECK_JOB} ${JOB}
clean: ${CLEAN_JOB}
.PHONY: all check clean ${JOB} ${CHECK_JOB} ${CLEAN_JOB}

${JOB}: core-%: Dockerfile
	docker build \
	  --build-arg CORE_TAG=$* \
	  --tag dwolla/jenkins-agent-mono:$*-SNAPSHOT \
	  .

${CLEAN_JOB}: clean-%:
	docker image rm --force dwolla/jenkins-agent-mono:$*-SNAPSHOT