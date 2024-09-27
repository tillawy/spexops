# ActiveRecord model: PointOfView
module Features
  class PointOfView < ApplicationRecord
    include Discard::Model
    default_scope -> { kept }
    belongs_to :project

    has_many :feature_point_of_view_memberships
    has_many :features, through: :feature_point_of_view_memberships

    validates_length_of :name, minimum: 4, maximum: 65

    scope :for_user, ->(user:) {
      PointOfView.joins(project: :project_user_memberships).where('project_user_memberships.user': user)
    }
  end
end
