source 'https://rubygems.org'
ruby '2.7.2'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rails', '~> 6.1.5'

# WebServer
gem 'puma', '~> 5.6'
gem 'rack-cors', '~> 1.1.1'

# Graphql
gem 'graphql', '~> 2.0.11'
gem 'graphql-batch', '~> 0.5.1'

# Database
gem 'pg', '~> 1.4.1'
gem 'redis', '~> 4.6.0'
gem 'strong_migrations', '~> 1.2.0'

# Environment variables
gem 'dotenv-rails', '~> 2.7.6'

# Authentication
gem 'jwt', '~> 2.4.1'

# Encryption
gem 'bcrypt', '~> 3.1.18'

# Monitoring errors
gem 'graphiql-rails', '~> 1.8.0'
gem 'sentry-rails'
gem 'sentry-ruby'

group :development, :test do
  gem 'bullet', '~> 7.0.2'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 2.21.0'
  gem 'rspec-rails', '~> 5.1.2'
end

group :development do
  gem 'annotate', '~> 3.2.0'
  gem 'letter_opener', '~> 1.8.1'
  gem 'listen', '>= 3.0.5', '< 3.8'
  gem 'reek', '~> 6.1.1', require: false
  gem 'rubocop', '~> 1.30.1', require: false
  gem 'rubocop-rails', '~> 2.15.0', require: false
  gem 'rubocop-rspec', '~> 2.11.1', require: false
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-json_expectations', '~> 2.2.0'
  gem 'shoulda-matchers', '~> 5.1.0'
  gem 'simplecov', '~> 0.21.2'
  gem 'webmock', '~> 3.14.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
