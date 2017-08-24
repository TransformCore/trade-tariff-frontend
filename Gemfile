source "https://rubygems.org"
ruby "2.3.3"

gem "rails", "5.0.0"

gem "yajl-ruby", "~> 1.2", require: "yajl"
gem "multi_json", "~> 1.11"
gem "httparty", "~> 0.13"
gem "hashie", "~> 3.4"
gem "govspeak", "~> 3.6", ">= 3.6.2"

gem "govuk_template", "0.20.0"
gem "addressable", "~> 2.3"

gem "coffee-rails", "~> 4.2.2", ">= 4.1.0"
gem "govuk_frontend_toolkit", "~> 4.18", ">= 4.18.4"
gem 'govuk_elements_rails', '~> 1.2', '>= 1.2.2'
gem "jquery-rails", "~> 4.2.2"
gem 'jquery-migrate-rails'
gem "sass-rails", "~> 5.0.6"
gem "uglifier", "~> 2.7"
gem "responders", "~> 2.1", ">= 2.1.0"
gem "bootscale", "~> 0.5", require: false

# Logging
gem "logstash-event"
gem "lograge", ">= 0.3.6"

# Web Server
gem "puma"
gem "rack-timeout", "~> 0.4"

# Memcache
gem "dalli", "~> 2.7"
gem "connection_pool", "~> 2.2"

# AWS
gem "aws-sdk", "~> 2"
gem "aws-sdk-rails", ">= 1.0.1"

group :development do
  gem "web-console", ">= 3.3.0"
  gem "letter_opener"
end

group :development, :test do
  # gem "quiet_assets", ">= 1.1.0"
  gem "pry-rails"
  gem "dotenv-rails"
end

group :test do
  gem "rails-controller-testing"
  gem "webmock", "~> 3.0.1"
  gem "factory_girl_rails", "~> 4.8.0"
  gem "forgery"
  gem "shoulda-matchers", "~> 3.1.1"
  gem "vcr", "~> 3.0.3"
  gem "simplecov", "~> 0.14.1"
  gem "simplecov-rcov", "~> 0.2.3"
  gem "rspec-rails", "~> 3.5.2"
  gem "capybara", "~> 2.13.0"
  gem "poltergeist", "~> 1.14.0"
  gem "timecop", "~> 0.8.1"
  gem "rspec_junit_formatter"
end

group :production do
  gem "rails_12factor"
  gem "sentry-raven"
  gem "newrelic_rpm"
end
