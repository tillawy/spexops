# ActiveRecord model: Milestone
module Features
  class Milestone < ApplicationRecord
    include Discard::Model
    default_scope -> { kept }
    enum :status, { pending: 1, open: 2, paused: 3, closed: 4 }

    belongs_to :project
  end
end
