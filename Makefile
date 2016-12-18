.PHONY: base

base:
	docker build --tag mrksr/base base/base
	docker build --tag mrksr/uwsgi base/uwsgi
	docker build --tag mrksr/php base/php

all: base
