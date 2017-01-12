FROM mrksr/base
MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      libldap2-dev \
      libsasl2-dev \
      libssl-dev \
      python \
      python-dev \
      python-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    python-ldap

RUN mkdir -p /ldap_auth
COPY ./nginx-ldap-auth-daemon.py /ldap_auth/nginx-ldap-auth-daemon.py

WORKDIR /ldap_auth
EXPOSE 8888
CMD [ "python", "-u", "nginx-ldap-auth-daemon.py", "--host", "0.0.0.0", "--port", "8888" ]
