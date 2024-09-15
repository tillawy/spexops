# ActiveRecord model: FeaturePointOfViewMembership
module Features
  class FeaturePointOfViewMembership < ApplicationRecord
    include Discard::Model
    include WithAutoProjectId
    default_scope -> { kept }

    belongs_to :feature
    belongs_to :point_of_view
  end
end
