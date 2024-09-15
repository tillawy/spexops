# ActiveRecord model: User
module Features
  class User < ApplicationRecord
    include Discard::Model
    default_scope -> { kept }

    has_many :project_user_memberships
    has_many :projects, through: :project_user_memberships
  end
end
