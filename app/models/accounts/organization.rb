# Model: Organization
module Accounts
  class Organization < Base
    after_create_commit { broadcast_prepend_later_to "organizations" }
    after_update_commit { broadcast_replace_to "organizations" }
    after_destroy_commit { broadcast_remove_to "organizations" }

    include Discard::Model
    default_scope -> { kept }
    encrypts :name, deterministic: true

    validates :name, presence: true, on: :create
    validates_length_of :name, minimum: 4, maximum: 20, allow_blank: false

    has_many :organization_user_memberships, dependent: :destroy
    has_many :users, through: :organization_user_memberships
  end
end
