FROM mrksr/uwsgi-python2
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      libldap2-dev \
      libsasl2-dev \
      libssl-dev \
      python-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    radicale \
    python-ldap
