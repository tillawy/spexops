# rubocop:disable Rails/ApplicationRecord
module Versions
  class Base < ActiveRecord::Base
    # rubocop:enable Rails/ApplicationRecord
    self.abstract_class = true
    connects_to database: {writing: :versions}
  end
end
