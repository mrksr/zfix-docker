FROM mrksr/base
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    mumble-server \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 64738

CMD ["murmurd", "-ini", "/etc/mumble-server.ini", "-fg"]
