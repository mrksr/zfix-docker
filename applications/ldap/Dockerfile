FROM ubuntu:22.04
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    slapd \
    ldap-utils \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 389

# Set ulimit to "fix" slapd assertion error.
# See https://github.com/moby/moby/issues/8231
CMD ulimit -n 1024 && /usr/sbin/slapd -h "ldap:/// ldapi://localhost/" -u openldap -g openldap -d 256
