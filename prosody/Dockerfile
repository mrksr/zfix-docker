FROM mrksr/base
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    rsyslog \
    prosody \
    ca-certificates \
    openssl-blacklist \
    lua-zlib \
    lua-dbi-postgresql \
    lua5.1-sec \
    lua5.1-event \
    mercurial \
    && rm -rf /var/lib/apt/lists/*

RUN hg clone https://hg.prosody.im/prosody-modules/ /opt/prosody-modules && \
    chown -R prosody:prosody /opt/prosody-modules

COPY ./wait-for-it.sh /usr/bin/wait-for-it.sh

EXPOSE 5222
EXPOSE 5269
EXPOSE 5280

CMD ["wait-for-it.sh", "database:5432", "-t", "120", "--", "prosody"]
