FROM mrksr/base
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      lsb-release \
      wget \
    && wget https://prosody.im/files/prosody-debian-packages.key -O- \
      | apt-key add - \
    && echo deb http://packages.prosody.im/debian $(lsb_release -sc) main \
      | tee -a /etc/apt/sources.list \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      ca-certificates \
      lua-bitop \
      lua-dbi-mysql \
      lua-ldap \
      lua-zlib \
      lua5.1-event \
      lua5.1-sec \
      mercurial \
      openssl-blacklist \
      prosody-0.10 \
    && rm -rf /var/lib/apt/lists/*

RUN hg clone https://hg.prosody.im/prosody-modules/ /opt/prosody-modules && \
    chown -R prosody:prosody /opt/prosody-modules

COPY ./wait-for-it.sh /usr/bin/wait-for-it.sh

EXPOSE 5222 5269 5347 5280 5281

CMD ["wait-for-it.sh", "database:3306", "-t", "120", "--", "prosody"]
