FROM mrksr/php
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      git \
      mercurial \
      supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN bash -c "shopt -s dotglob; rm -rf /srv/*" \
    && git clone https://github.com/movim/movim.git /srv \
    && cd /srv \
    && curl -sS https://getcomposer.org/installer | php \
    && php composer.phar install \
    # && php mud.php db --set \
    && chown www-data:www-data -R /srv

EXPOSE 8000

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
