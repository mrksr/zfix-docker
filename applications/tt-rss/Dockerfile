FROM mrksr/php
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      git \
    && rm -rf /var/lib/apt/lists/*

RUN bash -c "shopt -s dotglob; rm -rf /srv/*" \
    && git clone https://tt-rss.org/git/tt-rss.git /srv \
    && mkdir -p /srv/plugins.repos \
    && git clone https://github.com/hydrian/TTRSS-Auth-LDAP /srv/plugins.repos/TTRSS-Auth-LDAP \
    && git clone https://github.com/jangernert/FeedReader /srv/plugins.repos/FeedReader \
    && ln -s /srv/plugins.repos/FeedReader/data/tt-rss-feedreader-plugin/api_feedreader /srv/plugins.local \
    && ln -s /srv/plugins.repos/TTRSS-Auth-LDAP/plugins/auth_ldap /srv/plugins.local \
    && chown www-data:www-data -R /srv

VOLUME /srv
