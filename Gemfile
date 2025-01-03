source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
gem "solid_queue"
gem "solid_cache"
gem "solid_cable", "~> 3.0"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
  gem "rubocop", "~> 1.69", require: false
  gem "rubocop-performance"
  gem "rubocop-rails"
  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  gem "bundler-audit", require: false
  gem "rubycritic", require: false
  gem "guard"
  gem "guard-rspec", require: false
  gem "guard-rubycritic", require: false
  gem "guard-process"
  gem "guard-rubocop"
  gem "database_consistency", require: false
  gem "faker"
  gem "prosopite"
  gem "pg_query"
  gem "rspec-rails", "~> 7"
  gem "rswag-specs"
  gem "webmock"
  gem "factory_bot_rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "ruby-lsp"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "pundit-matchers"
end

gem "rls_rails", github: "sbiastoch/rls_rails", branch: "master"
gem "omniauth"
gem "omniauth-rails_csrf_protection"
gem "omniauth-keycloak"
gem "rails_keycloak_authorization"
gem "paper_trail"
gem "pundit"

gem "prometheus_exporter"

gem "graphql"
gem "rails-pg-extras"
gem "discard", "~> 1.2"
gem "graphiql-rails"
gem "ancestry"
gem "rswag-api"
gem "rswag-ui"
gem "ostruct" # for rswag, remove later
gem "dry-struct"

