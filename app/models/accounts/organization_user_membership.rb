module Accounts
  class OrganizationUserMembership < Base
    include Discard::Model
    default_scope -> { kept }

    belongs_to :user
    belongs_to :organization
    enum :invitation_status, { invitation_status_none: 0, opened: 1, accepted: 2, rejected: 3 }
    enum :role, { role_none: 0, owner: 1, admin: 2, financial: 3, member: 4 }
  end
end
