require "keycloak-admin"

KeycloakAdmin.configure do |config|
  config.use_service_account = true
  config.server_url = ENV.fetch("KEYCLOAK_AUTH_SERVER_URL", "http://login.spexops.local:8080")
  config.server_domain = ENV["KEYCLOAK_SERVER_DOMAIN"]
  config.client_id = "spx-admin"
  config.client_realm_name = "master"
  config.client_secret = ENV.fetch("KEYCLOAK_ADMIN_CLIENT_SECRET") { "im9trehLaUa12fCYbVLKAgJrUmpauxmf" }
  config.logger = Rails.logger
  config.rest_client_options = {verify_ssl: false}
end

####
# https://www.keycloak.org/docs/latest/server_admin/index.html#_service_accounts
# Create Admin User
# go to realm: Master
# create client: spx-admin
#    Client authentication: On
#    Service account roles: on
#    access-type: confidential
#    valid redirect URI: /realms/${realm}/spx-admin/
#    service-accounts-enabled: true
#    last-tab: Service Accounts Role
#        client roles: master-realm & SpexNuc-Realm:
#          add roles:
#             view-realm
#             manage-users
#             view-clients

