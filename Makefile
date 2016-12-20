.PHONY: base uwsgi php

all: base uwsgi php

base:
	docker build --tag mrksr/base base/base

uwsgi:
	docker build --tag mrksr/uwsgi base/uwsgi
	docker build --tag mrksr/uwsgi-python2 --file base/uwsgi/Dockerfile.python2 base/uwsgi

php:
	docker build --tag mrksr/php base/php
