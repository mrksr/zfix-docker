FROM mayanedms/mayanedms

# Add more OCR languages
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    tesseract-ocr-deu \
    tesseract-ocr-swe \
    && rm -rf /var/lib/apt/lists/*

# Add dependencies for LDAP auth
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/* \
    && sudo -u mayan $PYTHON_PIP install --no-cache-dir \
    python-ldap==2.4.41 \
    django-auth-ldap==1.2.14

# Fix UID to work with syncthing
RUN find / -path /proc -prune -o -user mayan -print0 | xargs -0 chown -h 1042 \
    && usermod -u 1042 mayan
