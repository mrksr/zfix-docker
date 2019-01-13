FROM alpine:latest
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN apk add --update murmur icu-libs \
    && rm -rf /var/cache/apk/*

EXPOSE 64738/udp 64738/tcp

CMD ["/usr/bin/murmurd", "-ini", "/etc/mumble-server.ini", "-fg"]
