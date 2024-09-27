# frozen_string_literal: true

require "rails_helper"

RSpec.describe Accounts::Organization, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:organization_user_memberships) }
    it { is_expected.to have_many(:users).through(:organization_user_memberships) }
  end
end
