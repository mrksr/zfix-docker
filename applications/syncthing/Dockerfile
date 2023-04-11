FROM ubuntu:22.04
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
    && ( curl -s https://syncthing.net/release-key.txt \
    | apt-key add - ) \
    && ( echo "deb https://apt.syncthing.net/ syncthing release" \
    | tee /etc/apt/sources.list.d/syncthing.list ) \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      syncthing \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8384 22000 21027/UDP
USER 1042:1042

CMD ["syncthing", "-gui-address", "0.0.0.0:8384", "-home", "/syncthing/config"]
