module Accounts
  class User < Base
    include Discard::Model
    default_scope -> { kept }
    encrypts :email, deterministic: true, downcase: true

    validates :email, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

    after_commit do
      ActiveSupport::Notifications.instrument("created.user", { user: self })
    end

    has_many :organization_user_memberships, dependent: :destroy
    has_many :organizations, through: :organization_user_memberships
  end
end
