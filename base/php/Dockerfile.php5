FROM php:5-fpm
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        libc-client-dev \
        libc-client2007e-dev \
        libcurl3 \
        libcurl3-dev \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libkrb5-dev \
        libldap2-dev \
        libldb-dev \
        libmagickwand-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        libpspell-dev \
        libssl-dev \
        libtidy-dev \
        libxml2-dev \
        libzip-dev \
        libzmq3-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) curl \
    && docker-php-ext-install -j$(nproc) ftp \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) gettext \
    && docker-php-ext-install -j$(nproc) hash \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) mbstring \
    && docker-php-ext-install -j$(nproc) mcrypt \
    && docker-php-ext-install -j$(nproc) mysql \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) opcache \
    && docker-php-ext-install -j$(nproc) pcntl \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) pgsql \
    && docker-php-ext-install -j$(nproc) posix \
    && docker-php-ext-install -j$(nproc) pspell \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) sockets \
    && docker-php-ext-install -j$(nproc) tidy \
    && docker-php-ext-install -j$(nproc) xml \
    && docker-php-ext-install -j$(nproc) zip \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# For some reason we need to do this alone
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install -j$(nproc) ldap

RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install -j$(nproc) imap

# Some special stuff
RUN pecl install zmq-beta \
    && docker-php-ext-enable zmq
