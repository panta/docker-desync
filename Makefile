GIT_COMMIT       := $$(git rev-parse HEAD)
GIT_COMMIT_SHORT := $$(git rev-parse --short HEAD)
#GIT_TAG          := $$(git describe --exact-match)

REPOSITORY     ?= panta/desync
DESYNC_VERSION ?= v0.7.1
# TAG            ?= ${GIT_TAG}
TAG            ?= ${DESYNC_VERSION}
IMAGE          := $(REPOSITORY):$(TAG)
LATEST         := $(REPOSITORY):latest

OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

.PHONY: all
all: build push

.PHONY: build
build:
	@echo "$(OK_COLOR)==>$(NO_COLOR) Building $(IMAGE)"
	@docker build --build-arg DESYNC_VERSION=$(DESYNC_VERSION) --rm -t $(IMAGE) .
	@docker tag $(IMAGE) ${LATEST}

.PHONY: push
push:
	@echo "$(OK_COLOR)==>$(NO_COLOR) Pushing $(REPOSITORY):$(TAG)"
	@docker push $(REPOSITORY)
