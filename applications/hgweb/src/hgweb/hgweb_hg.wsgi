#!/usr/bin/env python
# An example WSGI for use with mod_wsgi, edit as necessary
# See http://mercurial.selenic.com/wiki/modwsgi for more information

# Path to repo or hgweb config to serve (see 'hg help hgweb')
config = "hgweb_hg.config"

# Uncomment and adjust if Mercurial is not installed system-wide
# (consult "installed modules" path from 'hg debuginstall'):
#import sys; sys.path.insert(0, "/path/to/python/lib")

import os
os.environ["HGENCODING"] = "UTF-8"

# Uncomment to send python tracebacks to the browser if an error occurs:
#import cgitb; cgitb.enable()

# enable demandloading to reduce startup time
from mercurial import demandimport; demandimport.enable()

from mercurial.hgweb import hgweb
application = hgweb(config)
