FROM mrksr/base
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates \
    apt-transport-https \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -s https://syncthing.net/release-key.txt \
    | apt-key add -

RUN echo "deb https://apt.syncthing.net/ syncthing release" \
    | tee /etc/apt/sources.list.d/syncthing.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    syncthing \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8384 22000 21027/UDP

CMD ["syncthing", "-gui-address", "0.0.0.0:8384", "-home", "/syncthing/config"]
