FROM mrksr/base
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      gnupg \
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
      dovecot-lmtpd \
      dovecot-managesieved \
      dovecot-sieve \
      opendkim \
      openssl \
      postfix \
      postfix-ldap \
      rspamd \
      rsyslog \
      supervisor \
    && find / -path /proc -prune -o -group _rspamd -exec chgrp -h 4000 {} \; \
    && groupmod -g 4000 _rspamd \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 5000 vmail && \
    useradd -g vmail -u 5000 -d /srv/vmail -M -s /usr/sbin/nologin vmail && \
    mkdir -p /run/rspamd

VOLUME /vmail

EXPOSE 25 110 143 465 587 993 995 4190

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
