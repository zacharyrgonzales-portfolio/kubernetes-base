SHELL :=/bin/sh -eo pipefail

.PHONY: lint-manifests help

create-cluster: ## run kind to create a k8s cluster
	kind create cluster

lint-manifests: ## run lint on kubenetes manifests
	find . -type f -regex '.*\.ya*ml' ! -path '*/.codefresh/*' ! -path '*/helm/*' ! -path '*/bootstrap/*' ! -path '*/helm-seedling/*' ! -path '*/bootstrap-seedling/*' |xargs kubeval --ignore-missing-schemas

check-argocd-autopilot-env-vars: ## check for correct argocd autopilot environment variables
ifndef GIT_TOKEN
	$(error GIT_TOKEN is not defined; example: `make GIT_TOKEN=<git_token>`)
endif
ifndef GIT_REPO
	$(error GIT_REPO is not defined; example: `make GIT_REPO=<git_repo_url>`)
endif
	@true

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help