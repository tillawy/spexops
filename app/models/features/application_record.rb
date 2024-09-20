module Features
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    connects_to database: { writing: :features }
    has_paper_trail versions: {
      class_name: Versions::Version.name
    }
  end
end
