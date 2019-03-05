source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 4.0'
gem 'bcrypt', '~> 3.1.7'
gem 'active_interaction', '~> 3.7'
gem 'open-weather', '~> 0.12.0'
gem 'twilio-ruby', '~> 5.20.1'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'sidekiq', '~> 5.2.5'
gem 'sidekiq-scheduler', '~> 3.0.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails', require: false
  gem 'dotenv-rails', '~> 2.7.1'
  gem 'faker', '~> 1.9.3'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.8'
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end