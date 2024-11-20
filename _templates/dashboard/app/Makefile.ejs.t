---
to: Makefile
---

SHELL                 = /bin/bash

VERSION               = $(shell git describe --always --tags $(shell git rev-list --tags --skip=${SKIP_VERSION} --max-count=1))
GIT_COMMIT            = $(shell git rev-parse HEAD)
GIT_DIRTY             = $(shell test -n "`git status --porcelain`" && echo "+CHANGES" || true)
BUILD_DATE            = $(shell date '+%Y-%m-%d-%H:%M:%S')
SQUAD                 = frontend
BUSINESS              = platform

.PHONY: default
default: help

.PHONY: help
help:
	@echo 'Management commands for ${APP_NAME}:'
	@echo
	@echo 'Usage:'
	@echo '    make install                            Install dependencies.'
	@echo '    make config                             Build config for build time.'
	@echo '    make rollback RELEASE= REVISION=        Rollback via Helm. If REVISION is omitted, it will roll back to the previous release.'
	@echo

.PHONY: setup
setup:
	make setup-tools
	make setup-domains

.PHONY: setup-tools
setup-tools:
	@echo "Setup local tools for dashboard"
	export HOMEBREW_PREFIX=$(shell brew --prefix) && \
	npx zx scripts/setupTools.js

.PHONY: setup-domains
setup-domains:
	@echo "Setup local domains for dashboard"
	export HOMEBREW_PREFIX=$(shell brew --prefix) && \
	npx zx scripts/setupDomains.js

.PHONY: install
install:
	@echo "Installing dependencies"
	CI=true pnpm install --frozen-lockfile

.PHONY: config
config:
	@for f in $(shell ls apps); \
	do $(MAKE) -C ${CURDIR}/apps/$${f} config; \
	done

.PHONY: rollback
rollback:
	@echo "Rollback ${RELEASE} ${REVISION}"
	helm rollback \
		--namespace ${APP_NAME} \
		${RELEASE} ${REVISION}

.PHONY: helm-history-length
helm-history-length:
	@helm history \
		--namespace ${APP_NAME} \
		--output yaml \
		${APP_NAME}-server-${ENV_NAME} | \
	yq eval 'length' -

.PHONY: helm-oldest-revision
helm-oldest-revision:
	@helm history \
		--namespace ${APP_NAME} \
		--output yaml \
		${APP_NAME}-server-${ENV_NAME} | \
	yq eval '.[0].revision' -

.PHONY: helm-image-tag
helm-image-tag:
	@helm get values \
		--namespace ${APP_NAME} \
		--revision ${REVISION} \
		--output yaml \
		${APP_NAME}-server-${ENV_NAME} | \
	yq eval '.image.tag' -

.PHONY: helm-image-timestamp
helm-image-timestamp:
	@gcloud container images list-tags \
	--filter="tags:${REVISION_IMAGE}" ${DOCKER_REPOSITORY}/${APP_NAME} | \
	awk 'FNR == 2 { print $$3 }'

.PHONY: prune
prune:
	@echo "Removing Docker image ${DOCKER_REPOSITORY}/${APP_NAME} ${ENV_NAME} by oldest timestamp ${REVISION_TIMESTAMP}"
	gcloud container images list-tags \
		--filter="timestamp.datetime < ${REVISION_TIMESTAMP}"  \
		--format="get(digest)" \
		${DOCKER_REPOSITORY}/${APP_NAME} | \
	awk -v img="${DOCKER_REPOSITORY}/${APP_NAME}" '{print img "@" $$1}' | \
	xargs gcloud container images delete \
		--force-delete-tags \
		--quiet

.PHONY: prune-all
prune-all:
	@echo "Removing Docker image ${DOCKER_REPOSITORY}/${APP_NAME} ${ENV_NAME}"
	gcloud container images list-tags \
		--filter="tags ~ ${ENV_NAME}"  \
		--format="get(digest)" \
		${DOCKER_REPOSITORY}/${APP_NAME} | \
	awk -v img="${DOCKER_REPOSITORY}/${APP_NAME}" '{print img "@" $$1}' | \
	xargs gcloud container images delete \
		--force-delete-tags \
		--quiet
