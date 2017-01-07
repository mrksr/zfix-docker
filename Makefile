.PHONY: base uwsgi php
MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all: base uwsgi php zfix-docker@.service

base:
	docker build --tag mrksr/base base/base

uwsgi:
	docker build --tag mrksr/uwsgi base/uwsgi
	docker build --tag mrksr/uwsgi-python2 --file base/uwsgi/Dockerfile.python2 base/uwsgi

php:
	docker build --tag mrksr/php base/php

zfix-docker@.service:
	sed -e "s!{{REPO_PATH}}!$(MAKEFILE_DIR)!g" zfix-docker@.service.in > zfix-docker@.service
