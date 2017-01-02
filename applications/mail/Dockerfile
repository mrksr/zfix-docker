FROM mrksr/base
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      lsb-release \
      wget \
    && wget https://rspamd.com/apt-stable/gpg.key -O- \
      | apt-key add - \
    && echo deb http://rspamd.com/apt-stable/ $(lsb_release -sc) main \
      | tee -a /etc/apt/sources.list \
    && echo deb-src http://rspamd.com/apt-stable/ $(lsb_release -sc) main \
      | tee -a /etc/apt/sources.list \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      dovecot-common \
      dovecot-imapd \
      dovecot-ldap \
      dovecot-lmtp \
      dovecot-managesieved \
      dovecot-sieve \
      opendkim \
      openssl \
      postfix \
      postfix-ldap \
      rmilter \
      rspamd \
      supervisor \
    && rm -rf /var/lib/apt/lists/*

VOLUME /vmail

EXPOSE 25 110 143 465 587 993 995 4190

CMD ["/usr/bin/supervisord"]
