.PHONY: base

base:
	docker build --tag mrksr/base base/base
	docker build --tag mrksr/uwsgi base/uwsgi

all: base
