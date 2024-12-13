if ENV["COVERAGE"]
  require "simplecov"
  require "simplecov-console"
  require "simplecov-csv"
  SimpleCov.formatters = if ENV["COVERAGE_ONLY_HTML"]
    SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])
  else
    SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::CSVFormatter, SimpleCov::Formatter::Console])
  end

  SimpleCov.start "rails" do
    add_filter "app/channels/"
    add_filter "app/jobs/"
    add_filter "app/admin/"
    add_group "Policies", "app/policies/"
    add_group "Queries", "app/queries/"
    add_group "Services", "app/services/"
  end
  SimpleCov.minimum_coverage 80
  SimpleCov.minimum_coverage_by_file 80
  SimpleCov.refuse_coverage_drop
  SimpleCov.coverage_dir "public/coverage"
end

require "shared/contexts/jwt_user"
require "shared/examples/rswag_unprocessable"
require "shared/contexts/rswag_order_params"
require "shared/contexts/rswag_order_params_values"


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
