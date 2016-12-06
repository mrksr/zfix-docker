admins = { "markus@zfix.org" }

use_libevent = true;
plugin_paths = { "/opt/prosody-modules" }

modules_enabled = {
  -- Generally required
  "roster"; -- Allow users to have a roster. Recommended ;)
  "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
  "tls"; -- Add support for secure TLS on c2s/s2s connections
  "dialback"; -- s2s dialback support
  "disco"; -- Service discovery

  -- Not essential, but recommended
  "private"; -- Private XML storage (for room bookmarks, etc.)
  "vcard"; -- Allow users to set vCards
  "blocklist"; -- Support privacy lists

  -- Nice to have
  "legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
  "version"; -- Replies to server version requests
  "uptime"; -- Report how long server has been running
  "time"; -- Let others know the time here on this server
  "ping"; -- Replies to XMPP pings with pongs
  "pep"; -- Enables users to publish their mood, activity, playing music and more
  "register"; -- Allow users to register on this server using a client and change passwords
  "adhoc"; -- Support for "ad-hoc commands" that can be executed with an XMPP client

  -- Admin interfaces
  "admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
  --"admin_telnet"; -- Opens telnet console interface on localhost port 5582

  -- Other specific functionality
  --"groups"; -- Shared roster support
  --"announce"; -- Send announcement to all online users
  --"welcome"; -- Welcome users who register accounts
  "watchregistrations"; -- Alert admins of registrations
  --"motd"; -- Send a message to users when they log in

  -- Jappix
  "http"; -- Serve static files from a directory over HTTP
  "bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
  "websocket";
  -- "pubsub"; -- Load only in component
  "vjud";

  -- custom
  "mam"; -- server side message archive
  -- "mam_muc"; -- ... for MUC, but load only in component
  "mam_archive"; -- Implement XEP-0136 using mam
  "carbons"; -- outgoing messages copy
  "smacks"; -- unstable connections
  "csi"; -- Client State Indication
};

modules_disabled = {
  -- "offline"; -- Store offline messages
  -- "c2s"; -- Handle client connections
  -- "s2s"; -- Handle server-to-server connections
  -- "posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
};

disco_items = {
  { "muc.zfix.org" },
  -- { "proxy.zfix.org" },
  { "pubsub.zfix.org" },
  { "vjud.zfix.org" }
};

default_archive_policy = false;
max_archive_query_results = 500;

muc_log_by_default = true;
muc_log_all_rooms = false;
-- max_history_messages = 1000;

consider_websocket_secure = false;
cross_domain_websocket = true;

consider_bosh_secure = false;
cross_domain_bosh = true;
bosh_max_inactivity = 30;

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = true;

daemonize = false;

-- ssl = {
--   -- key = "/srv/CA/private/jabber.key.pem";
--   -- certificate = "/srv/CA/certs/jabber.crt.pem";
--   key = "/etc/letsencrypt/live/zfix.org/privkey.pem";
--   certificate = "/etc/letsencrypt/live/zfix.org/fullchain.pem";

--   protocol = "tlsv1+";
--   ciphers = "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA";
--   dhparam = "dhparam.pem";
-- }

-- c2s_require_encryption = true
-- s2s_require_encryption = false

authentication = "internal_hashed"

default_storage = "sql"
storage = {
  archive2 = "sql";
  muc_log = "sql"
}

sql = {
  driver = "PostgreSQL",
  database = "prosody",
  username = "prosody",
  password = "prosody",
  host = "database"
}

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
-- log = {
--     -- Log files (change 'info' to 'debug' for debug logs):
--     info = "/var/log/prosody/prosody.log";
--     error = "/var/log/prosody/prosody.err";
--     -- Syslog:
--     { levels = { "error" }; to = "syslog";  };
-- }

Include "zfix.org.cfg.lua"
