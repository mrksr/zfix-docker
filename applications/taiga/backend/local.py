# -*- coding: utf-8 -*-
# https://github.com/taigaio/taiga-back/blob/master/settings/local.py.example
from .common import *
import environ


env = environ.Env()
DEBUG = env('DJANGO_DEBUG', cast=bool, default=False)
PUBLIC_REGISTER_ENABLED = env(
    'TAIGA_PUBLIC_REGISTER_ENABLED', cast=bool, default=True
)

SECRET_KEY = env('DJANGO_SECRET_KEY')
ALLOWED_HOSTS = env('DJANGO_ALLOWED_HOSTS', cast=list, default=['*'])

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': env('DJANGO_DB_NAME'),
        'USER': env('DJANGO_DB_USER'),
        'PASSWORD': env('DJANGO_DB_PASSWORD'),
        'HOST': 'postgresql',
        'PORT': '',
    }
}

TAIGA_HOSTNAME = env('TAIGA_HOSTNAME', default='localhost')

_HTTP = 'https' if env('TAIGA_SSL', cast=bool, default=False) else 'http'
_HTTP_URL = 'https' if _HTTP == 'https' or env('TAIGA_FORCE_HTTPS_URL', cast=bool, default=False) else 'http'

SITES = {
    "api": {
       "scheme": _HTTP,
       "domain": TAIGA_HOSTNAME,
       "name": "api"
    },
    "front": {
      "scheme": _HTTP,
      "domain": TAIGA_HOSTNAME,
      "name": "front"
    },
}

SITE_ID = "api"

MEDIA_URL = "{}://{}/media/".format(_HTTP_URL, TAIGA_HOSTNAME)
STATIC_URL = "{}://{}/static/".format(_HTTP_URL, TAIGA_HOSTNAME)
MEDIA_ROOT = '/taiga_backend/media'
STATIC_ROOT = '/taiga_backend/static-root'

# Async
# see celery_local.py
EVENTS_PUSH_BACKEND = "taiga.events.backends.rabbitmq.EventsPushBackend"
EVENTS_PUSH_BACKEND_OPTIONS = {"url": "amqp://taiga:taiga@rabbitmq:5672/taiga"}

# see celery_local.py
CELERY_ENABLED = True
WEBHOOKS_ENABLED = True

# Mail settings
EMAIL_BACKEND = 'djmail.backends.async.EmailBackend'
DJMAIL_REAL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_USE_TLS = True
EMAIL_USE_SSL = False
EMAIL_HOST = env('MAIL_HOST')
EMAIL_PORT = env('MAIL_PORT', default=25)
EMAIL_HOST_USER = env('MAIL_USER')
EMAIL_HOST_PASSWORD = env('MAIL_PASSWORD')
DEFAULT_FROM_EMAIL = "Taiga <{}>".format(env('DJANGO_DEFAULT_FROM_EMAIL'))

# Cache
# CACHES = {
#     "default": {
#         "BACKEND": "django.core.cache.backends.locmem.LocMemCache",
#         "LOCATION": "unique-snowflake"
#     }
# }

# LDAP
INSTALLED_APPS += ["taiga_contrib_ldap_auth_ext"]

LDAP_SERVER = 'ldap://ldap'
LDAP_PORT = 389

# Flag to enable LDAP with STARTTLS before bind
LDAP_START_TLS = False

# Support of alternative LDAP ciphersuites
#from ldap3 import Tls
#import ssl

#LDAP_TLS_CERTS = Tls(validate=ssl.CERT_NONE, version=ssl.PROTOCOL_TLSv1, ciphers='RSA+3DES')

# Full DN of the service account use to connect to LDAP server and search for login user's account entry
# If LDAP_BIND_DN is not specified, or is blank, then an anonymous bind is attempated
LDAP_BIND_DN = ''
LDAP_BIND_PASSWORD = ''

# Starting point within LDAP structure to search for login user
LDAP_SEARCH_BASE = 'ou=users,dc=zfix,dc=org'

# Additional search criteria to the filter (will be ANDed)
#LDAP_SEARCH_FILTER_ADDITIONAL = '(mail=*)'

# Names of attributes to get username, e-mail and full name values from
# These fields need to have a value in LDAP
LDAP_USERNAME_ATTRIBUTE = 'uid'
LDAP_EMAIL_ATTRIBUTE = 'mail'
LDAP_FULL_NAME_ATTRIBUTE = 'givenName'

# Fallback on normal authentication method if this LDAP auth fails. Uncomment to enable.
# LDAP_FALLBACK = "normal"

# Function to map LDAP username to local DB user unique identifier.
# Upon successful LDAP bind, will override returned username attribute
# value. May result in unexpected failures if changed after the database
# has been populated.
#
def _ldap_slugify(uid: str) -> str:
    # example: force lower-case
    uid = uid.lower()
    return uid

# To enable the function above, uncomment the line below to store the function in the variable
LDAP_MAP_USERNAME_TO_UID = _ldap_slugify

# Similarly, you can apply filters to the email and name by defining functions and specifying them here in the same way
#LDAP_MAP_EMAIL = _ldap_map_email
#LDAP_MAP_NAME = _ldap_map_name
