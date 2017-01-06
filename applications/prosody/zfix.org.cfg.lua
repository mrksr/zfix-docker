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
