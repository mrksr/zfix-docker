VirtualHost "zfix.org"
  enabled = true
  public_service_vcard = {
    name = "zfix XMPP service",
    url = "https://chat.zfix.org/",
    foundation_year = "2013",
    country = "DE",
    email = "pub@zfix.org",
    dmin_jid = "markus@zfix.org",
    oob_registration_uri = "https://zfix.org/"
  }


VirtualHost "anonymous.zfix.org"
  enabled = false
  authentication = "anonymous"
  allow_anonymous_multiresourcing = true
  allow_anonymous_s2s = true
  anonymous_jid_gentoken = "zfix.org Anonymous User"
  anonymous_randomize_for_trusted_addresses = { "127.0.0.1", "::1" }


---Set up a MUC (multi-user chat) room server on muc.zfix.org:
Component "muc.zfix.org" "muc"
  name = "zfix.org Chatrooms"
  modules_enabled = { "mam_muc" }


---Set up a PubSub server
Component "pubsub.zfix.org" "pubsub"
  name = "zfix.org Publish/Subscribe"
  modules_enabled = { "pubsub" }
  -- unrestricted_node_creation = true -- Anyone can create a PubSub node (from any server)


---Set up a VJUD service
Component "vjud.zfix.org" "vjud"
  name = "zfix.org User Directory"
  synchronize_to_host_vcards = "zfix.org"

-- ---Set up a BOSH service
-- Component "bind.zfix.org" "http"
--   modules_enabled = { "bosh" }

-- ---Set up a WebSocket service
-- Component "websocket.zfix.org" "http"
--   modules_enabled = { "websocket" }

-- ---Set up a BOSH + WebSocket service
-- Component "me.zfix.org" "http"
--   modules_enabled = { "bosh", "websocket" }

-- ---Set up a statistics service
-- Component "stats.zfix.org" "http"
--   modules_enabled = { "server_status" }

--   server_status_basepath = "/xmppd/"
--   server_status_show_hosts = { "zfix.org", "anonymous.zfix.org" }
--   server_status_show_comps = { "muc.zfix.org", "proxy.zfix.org", "pubsub.zfix.org", "vjud.zfix.org" }

-- ---Set up an API service
-- -- Important: uses modules from https://github.com/jappix/jappix-xmppd-modules
-- Component "api.zfix.org" "http"
--   modules_enabled = { "api_user", "api_muc" }

-- -- Set up a SOCKS5 bytestream proxy for server-proxied file transfers:
-- Component "proxy.zfix.org" "proxy65"
--   proxy65_acl = { "zfix.org", "anonymous.zfix.org" }
