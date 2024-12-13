require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "pundit/matchers"
# require 'capybara/rspec'
require "pundit/rspec"
require "webmock/rspec"

require_relative './support/driver'

selenium_app_host =  Socket.ip_address_list.find(&:ipv4_private?).try(:ip_address)

ALLOWED_WEBMOCK_ADDRESSES = [
  "googlechromelabs.github.io",
  "storage.googleapis.com",
  "github.com",
  "objects.githubusercontent.com",
  "127.0.0.1",
  "localhost:4000",
  "#{selenium_app_host}:4000",
  "127.0.0.1:9515", # chromedriver
  "localhost:9515", # chromedriver
  /chromedriver/,
  /chrome/
]

WebMock.disable_net_connect!(allow: ALLOWED_WEBMOCK_ADDRESSES)

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryBot::Syntax::Methods

  # config.include APIHelper, type: :request
  # config.fixture_path = Rails.root.join("spec/fixtures")
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |shoulda_config|
    shoulda_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
