# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:organizations).through(:organization_user_memberships) }
    it { is_expected.to have_many(:organization_user_memberships) }
  end
end
