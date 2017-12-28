FROM mrksr/php
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN bash -c "shopt -s dotglob; rm -rf /srv/*" \
    && cd /srv \
    && curl -sL https://repository.rainloop.net/installer.php | php \
    && chown www-data:www-data -R /srv

VOLUME /srv
