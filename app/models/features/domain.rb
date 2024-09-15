# ActiveRecord model: Domain
module Features
  class Domain < ApplicationRecord
    include Discard::Model
    default_scope -> { kept }

    belongs_to :creator, class_name: User.name
    belongs_to :project

    has_many :features

    validates_length_of :name, minimum: 2, maximum: 65

    UUID_PATTERN = '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
    has_ancestry cache_depth: true, primary_key_format: %r{\A#{UUID_PATTERN}(\/#{UUID_PATTERN})*\Z}

    scope :for_user, ->(user:) {
      Domain.joins(project: :project_user_memberships).where('project_user_memberships.user': user)
    }

    has_many :child_domains,
             class_name: Domain.name,
             foreign_key: :parent_domain_id,
             dependent: :destroy

    belongs_to :parent_domain,
               class_name: Domain.name,
               optional: true,
               touch: true,
               counter_cache: :child_domains_count

  end
end
