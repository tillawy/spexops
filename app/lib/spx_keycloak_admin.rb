module SpxKeycloakAdmin
  # @param [String] email
  # @return [KeycloakAdmin::UserRepresentation]
  def self.create(email:)
    keycloak_user = keycloak_create_user(email:)
    keycloak_force_update_password(id: keycloak_user.id)
    keycloak_user
  end

  def self.keycloak_create_user(email:)
    KeycloakAdmin.realm(ENV.fetch("KEYCLOAK_REALM") { "spexops" }).users.create!(email, email, SecureRandom.hex, false, "en")
  end

  def self.keycloak_force_update_password(id:)
    KeycloakAdmin.realm(ENV.fetch("KEYCLOAK_REALM") { "spexops" }).users.update(id, { requiredActions: [ "UPDATE_PASSWORD" ] })
  end
end
