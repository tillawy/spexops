require "swagger_helper"
# rubocop:disable RSpec/ContextWording
RSpec.shared_context "jwt_user", shared_context: :metadata do
  # rubocop:enable RSpec/ContextWording
  let(:current_user) { build(:user) }
  before do
    allow(User).to receive(:find_or_create_by!).with(email: current_user.email, id: nil).and_return(current_user)
    allow(User).to receive(:find).with(current_user.id).and_return(current_user)
  end

  let(:authorization) {
    rsa_private = OpenSSL::PKey::RSA.generate 2048
    payload = {id: current_user.id, email: current_user.email, exp: 1.day.from_now.to_i}
    token = JWT.encode payload, rsa_private, "RS256"
    "bearer #{token}"
  }
  # rubocop:disable RSpec/VariableName
  let(:Authorization) {
    # Capitalized, so Swagger to auto-detect it
    authorization
  }
  # rubocop:enable RSpec/VariableName
  let(:headers) {
    {
      "Content-Type": "application/json",
      Accept: "application/json",
      Authorization: authorization
    }
  }
end
