
module Accounts
  module CommandHandlers
    module User
      class Create
        extend ActiveModel::Naming
        include ActiveModel::Conversion
        include ActiveModel::Validations

        # @param [Dry::Struct] command
        # @param [String] current_user_id
        def self.handle(command:, current_user_id:)
          object = Accounts::User.find_or_create_by(id: command.id, email: command.email)
          if object.save
            OpenStruct.new(success?: true, object: object, errors: nil)
          else
            OpenStruct.new(success?: false, object: nil, errors: object.errors)
          end
        end
      end
    end
  end
end
