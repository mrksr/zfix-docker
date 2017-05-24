MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DOCKER_ARGS ?=
BASE_IMAGES = base base-php base-uwsgi
APPLICATIONS ?= $(patsubst applications/%/,%,$(wildcard applications/*/))

.PHONY: $(BASE_IMAGES) $(APPLICATIONS)
all: zfix-docker@.service $(BASE_IMAGES) $(APPLICATIONS)

$(APPLICATIONS): %:
	docker-compose --file applications/$@/docker-compose.yml pull --ignore-pull-failures
	docker-compose --file applications/$@/docker-compose.yml build --no-cache

base:
	docker build $(DOCKER_ARGS) --tag mrksr/base base/base

base-php:
	docker build $(DOCKER_ARGS) --tag mrksr/php base/php
	docker build $(DOCKER_ARGS) --tag mrksr/php-5 --file base/php/Dockerfile.php5 base/php

base-uwsgi:
	docker build $(DOCKER_ARGS) --tag mrksr/uwsgi base/uwsgi
	docker build $(DOCKER_ARGS) --tag mrksr/uwsgi-python2 --file base/uwsgi/Dockerfile.python2 base/uwsgi

zfix-docker@.service: zfix-docker@.service.in
	sed -e "s!{{REPO_PATH}}!$(MAKEFILE_DIR)!g" zfix-docker@.service.in > zfix-docker@.service
