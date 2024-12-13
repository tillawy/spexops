# rubocop:disable RSpec/ContextWording
RSpec.shared_context "rswag_order_params_values", shared_context: :metadata do
  # rubocop:enable RSpec/ContextWording
  let(:sort) { "created_at,desc" }
  let(:page) { "0" }
  let(:size) { "10" }
end
