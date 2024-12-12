# frozen_string_literal: true

require "rails_helper"

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join("swagger").to_s
  config.openapi_strict_schema_validation = true

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'

  def model(modul:, type:)
    name = "#{modul}::Commands::#{type.to_s.camelcase}::Create"
    command = name.constantize
    required = command.schema.keys.filter { |k| k.required }.map { |k| k.name }
    dict = {
      type: "object",
      properties: {
        url: { type: "string" },
        created_at: { type: "string", format: "date-time" },
        updated_at: { type: "string", format: "date-time" }
      },
      required: required
    }
    map = command.schema.keys.map { |k| { "#{k.name}": { type: k.type.name.to_s.gsub(/^NilClass \| /, "").downcase, nullable: !k.required } } }
    map.each do |k|
      dict[:properties].merge!(k)
    end
    dict
  end

  def ref(type:)
    "#/components/schemas/#{type}"
  end

  def page(type:)
    {
      type: "object",
      properties: {
        totalPages: { type: :integer },
        numberOfElements: { type: :integer },
        totalElements: { type: :integer },
        number: { type: :integer },
        first: { type: :boolean },
        last: { type: :boolean },
        empty: { type: :boolean },
        pageable: {
          pageNumber: { type: :integer },
          paged: { type: :boolean },
          unpaged: { type: :boolean }
        },
        sortable: {
          sort: { type: :string },
          order: { type: :string, enum: %w[asc desc] }
        },
        content: {
          type: "array",
          items: { "$ref" => ref(type: type) }
        }
      }
    }
  end

  schemas = Hash[*Accounts::Commands.constants.excluding(:Shared).map(&:downcase).map { |c|
    [ "#{c.to_s.pluralize}_page".to_sym, page(type: c), c, model(modul: "Accounts", type: c) ]
  }.flatten]

  config.openapi_specs = {
    "v1/swagger.json" => {
      openapi: "3.0.3",
      info: {
        title: "API V1",
        version: "v1"
      },
      paths: {},
      components: {
        securitySchemes: {
          keycloak: {
            type: "oauth2",
            flows: {
              implicit: {
                authorizationUrl: ENV.fetch("KEYCLOAK_AUTH_SERVER_URL", "http://app.spexops.local:8080") + "/realms/spexops/protocol/openid-connect/auth",
                scopes: {}
              }
            }
          }
        },
        schemas: schemas
      },
      servers: [
        {
          url: "http://{defaultHost}",
          variables: {
            defaultHost: {
              default: ""
            }
          }
        }
      ]
    }
  }
  config.openapi_format = :json
end
