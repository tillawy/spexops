# rubocop:disable RSpec/SharedContext
RSpec.shared_examples "rswag_unprocessable" do |name, unprocessable|
  # rubocop:enable RSpec/SharedContext
  response "422", "#{name} creation failure" do
    parameter name: name, in: :body, schema: { "$ref" => "#/components/schemas/#{name}" }
    let(name) { unprocessable }
    run_test! do |response|
      data = JSON.parse(response.body)
      expect(data["error"]).not_to be_nil
    end
  end
end
