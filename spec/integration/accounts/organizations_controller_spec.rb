require "swagger_helper"

describe Accounts::OrganizationsController, type: :request do
  include_context "jwt_user"

  path "/api/organizations" do
    get "test headers" do
      tags "Organizations"
      description "List Organizations"
      operationId "listOrganizations"
      consumes "application/foo"
      security [keycloak: []]
      response "406", "unsupported accept header" do
        run_test!
      end
    end

    get "List Organizations" do
      tags "Organizations"
      description "List Organizations"
      operationId "listOrganizations"
      consumes "application/json"
      security [keycloak: []]
      let!(:organization) { create(:organization_with_owner, owner: current_user) }
      include_context "rswag_order_params"

      response "200", "Organizations found" do
        include_context "rswag_order_params_values"

        schema "$ref" => "#/components/schemas/organizations_page"
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["content"].first["id"]).to eq(organization.id)
          expect(data["content"].first["url"]).to include("organizations/#{organization.id}")
        end
      end
    end

    post "create organization" do
      tags "Organizations"
      operationId "createOrganization"
      consumes "application/json"
      security [keycloak: []]

      response "201", "organization created" do
        let(:organization) { build(:organization) }
        schema "$ref" => "#/components/schemas/organization"
        parameter name: :organization, in: :body, schema: {"$ref" => "#/components/schemas/organization"}
        run_test! do |response|
          data = JSON.parse(response.body)
          membership = Organization.find(data["id"]).organization_user_memberships.where(role: :owner, user: current_user).first
          expect(membership).not_to be_nil
        end
      end

      include_examples "rswag_unprocessable", "organization", {name: nil}
    end
  end

  path "/api/organizations/{id}" do
    parameter name: "id", in: :path, type: :string, description: "id"
    let(:organization) { create(:organization_with_owner, owner: current_user) }
    let(:id) { organization.id }

    delete "delete organization" do
      tags "Organizations"
      description "update organization from provided data"
      operationId "updateOrganization"
      consumes "application/json"
      produces "application/json"
      security [keycloak: []]

      response "204", "deleted successfully" do
        run_test!
      end
    end

    patch "update organization" do
      tags "Organizations"
      description "update organization from provided data"
      operationId "updateOrganization"
      consumes "application/json"
      produces "application/json"
      security [keycloak: []]

      response "200", "updated successfully" do
        schema "$ref" => "#/components/schemas/organization"
        parameter name: :organization, in: :body, schema: {"$ref" => "#/components/schemas/organization"}
        run_test!
      end
    end

    get "get organization" do
      tags "Organizations"
      description "get organization from provided data"
      operationId "getOrganization"
      consumes "application/json"
      produces "application/json"
      security [keycloak: []]

      response "200", "get successfully" do
        schema "$ref" => "#/components/schemas/organization"
        run_test!
      end

      response "404", "organization not found" do
        let(:id) { "invalid" }
        run_test!
      end
    end
  end

  path "/api/organizations/schema" do
    get "get organizations schema" do
      tags "Organizations"
      description "update organization from provided data"
      operationId "schemaOrganization"
      consumes "application/json"
      produces "application/json"
      security [keycloak: []]

      response "200", "deleted successfully" do
        run_test!
      end
    end
  end
end

