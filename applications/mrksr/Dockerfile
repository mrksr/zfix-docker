FROM golang as builder
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    python3-pygments \
    wget \
    && rm -rf /var/lib/apt/lists/*

ENV HUGO_VERSION 0.82.0
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit.deb
RUN wget -O /tmp/hugo.deb  https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    dpkg -i /tmp/hugo.deb \
    && rm /tmp/hugo.deb

RUN git clone --recursive https://git.zfix.org/markus/mrksr.de /hugo

RUN cd /hugo && \
    hugo --debug --verbose --minify


FROM nginx
copy --from=builder /hugo/public /static
