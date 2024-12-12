module Accounts
  module Commands
    module User
      class Create < Dry::Struct
        include Dry.Types()
        schema schema.strict
        attribute :email, String
        attributes_from General::Commands::MandatoryId
      end
    end
  end
end
