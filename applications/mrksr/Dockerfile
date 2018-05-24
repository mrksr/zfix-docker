FROM nginx
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    python-pygments \
    wget \
    && rm -rf /var/lib/apt/lists/*

ENV HUGO_VERSION 0.40.3
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.deb
RUN wget -O /tmp/hugo.deb  https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    dpkg -i /tmp/hugo.deb \
    && rm /tmp/hugo.deb

RUN git clone --recursive https://git.zfix.org/markus/mrksr.de /hugo && \
    cd /hugo && \
    hugo && \
    mv public /static && \
    rm -rf /hugo
