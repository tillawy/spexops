Rails.application.config.middleware.use OmniAuth::Builder do
  provider :keycloak_openid, ENV.fetch("KEYCLOAK_RESOURCE", "spx-backend"),
    ENV.fetch("KEYCLOAK_CREDENTIALS_SECRET", "spx-backend-client-secret"),
    client_options: {
      site: ENV.fetch("KEYCLOAK_AUTH_SERVER_URL", "http://login.spexops.local:8080"),
      realm: ENV.fetch("KEYCLOAK_REALM", "spexops"),
      raise_on_failure: true,
      base_url: ""
    },
    name: "keycloak",
    provider_ignores_state: true
end

OmniAuth.config.logger = Rails.logger

OmniAuth.config.path_prefix = ENV.fetch("KEYCLOAK_AUTH_SERVER_PATH_PREFIX", "/oauth")

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development?
