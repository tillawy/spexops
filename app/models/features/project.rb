# ActiveRecord model: Project
module Features
  class Project < ApplicationRecord
    include Discard::Model
    default_scope -> { kept }

    has_many :project_user_memberships
    has_many :users, through: :project_user_memberships
    has_many :point_of_views
    has_many :features
    belongs_to :creator, class_name: User.name

  end
end
