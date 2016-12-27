FROM mrksr/base
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    slapd \
    ldap-utils \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 389

CMD ["/usr/sbin/slapd", "-h", "ldap:/// ldapi://localhost/", "-u", "openldap", "-g", "openldap", "-d", "256"]
