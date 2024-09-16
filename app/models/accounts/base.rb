# rubocop:disable Rails/ApplicationRecord
module Accounts
  class Base < ActiveRecord::Base
    # rubocop:enable Rails/ApplicationRecord
    self.abstract_class = true
    connects_to database: { writing: :accounts }
    has_paper_trail versions: {
      class_name: Versions::Version.name
    }
  end
end
