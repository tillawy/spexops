# ActiveRecord model: ProjectUserMembership
module Features
  class ProjectUserMembership < ApplicationRecord
    include Discard::Model
    default_scope -> { kept }

    belongs_to :user
    belongs_to :project

    enum :role, { nothing: 0, admin: 1, member: 2, read_only: 3 }
  end
end
