require 'capybara/rspec'
# require 'capybara-screenshot/rspec'

selenium_app_host = ENV.fetch("SELENIUM_APP_HOST") do
  Socket.ip_address_list
        .find(&:ipv4_private?)
        .try(:ip_address)
end

Capybara.configure do |config|
  config.server = :puma, { Silent: true }
  config.server_host = selenium_app_host
  config.server_port = 4000
end

RSpec.configure do |config|
  Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  config.before(:each, type: :system) do
    if ENV["SELENIUM_HOST"]
      driven_by(:selenium, using: :remote, options: { url: URI("http://#{ENV['SELENIUM_HOST']}:4444/wd/hub"), capabilities: :chrome }) do |_|
      end
    else
      driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
    end
  end
end
