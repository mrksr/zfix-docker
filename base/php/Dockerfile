FROM php:8-fpm
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
        libc-client-dev \
        libc-client2007e-dev \
        libcurl4 \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libkrb5-dev \
        libldap2-dev \
        libldb-dev \
        libmagickwand-dev \
        libpng-dev \
        libpq-dev \
        libpspell-dev \
        libssl-dev \
        libtidy-dev \
        libxml2-dev \
        libzip-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# For some reason we need to do this alone
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install -j$(nproc) ldap

RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install -j$(nproc) imap

# Some special stuff
RUN pecl channel-update pecl.php.net \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# Main extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) gettext \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) opcache \
    && docker-php-ext-install -j$(nproc) pcntl \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) pgsql \
    && docker-php-ext-install -j$(nproc) pspell \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) sockets \
    && docker-php-ext-install -j$(nproc) tidy \
    && docker-php-ext-install -j$(nproc) zip
