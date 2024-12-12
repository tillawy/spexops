
module Accounts
  module Commands
    module Organization
      class Create < Dry::Struct
        include Dry.Types()
        schema schema.strict
        attribute :name, String
        attribute :domain, String
        attributes_from General::Commands::OptionalId
      end
    end
  end
end
