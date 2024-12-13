# rubocop:disable RSpec/ContextWording
RSpec.shared_context "rswag_order_params", shared_context: :metadata do
  # rubocop:enable RSpec/ContextWording
  parameter name: "size", in: :query, type: :number, description: "page size", default: 10
  parameter name: "page", in: :query, type: :number, description: "page number", default: 0
  parameter name: "sort", in: :query, type: :string, description: "sort by", default: "created_at,desc"
end
