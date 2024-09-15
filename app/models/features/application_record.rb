module Features
  class ApplicationRecord < ActiveRecord::Base
    primary_abstract_class
    connects_to database: {writing: :features}
    has_paper_trail versions: {
      class_name: Versions::Version.name
    }
  end
end
