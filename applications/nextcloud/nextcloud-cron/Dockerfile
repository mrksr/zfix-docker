FROM nextcloud:fpm-alpine

# FIXME(mrksr): Fix for broken iconv. This is an evil ahck and should be
# removed.
# See https://github.com/nextcloud/docker/issues/1299
RUN apk add --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
    --allow-untrusted \
        gnu-libiconv \
        php7-iconv
ENV LD_PRELOAD=/usr/lib/preloadable_libiconv.so

RUN apk add --no-cache supervisor \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
