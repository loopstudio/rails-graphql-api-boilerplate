source 'https://rubygems.org'
ruby '2.7.2'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rails', '~> 6.1.3'

# WebServer
gem 'puma', '~> 5.4'
gem 'rack-cors', '~> 1.1.1'

# Graphql
gem 'graphql', '~> 1.12.14'
gem 'graphql-batch', '~> 0.4.3'

# Database
gem 'pg', '~> 1.2.3'
gem 'redis', '~> 4.4.0'
gem 'strong_migrations', '~> 0.7.8'

# Environment variables
gem 'dotenv-rails', '~> 2.7.6'

# Authentication
gem 'jwt', '~> 2.2.3'

# Encryption
gem 'bcrypt', '~> 3.1.16'

# Monitoring errors
gem 'graphiql-rails', '~> 1.7.0'
gem 'sentry-rails'
gem 'sentry-ruby'

group :development, :test do
  gem 'bullet', '~> 6.1.4'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 2.18.0'
  gem 'rspec-rails', '~> 5.0.1'
end

group :development do
  gem 'annotate', '~> 3.1.1'
  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '>= 3.0.5', '< 3.7'
  gem 'reek', '~> 6.0.5', require: false
  gem 'rubocop', '~> 1.18.4', require: false
  gem 'rubocop-rails', '~> 2.11.3', require: false
  gem 'rubocop-rspec', '~> 2.4.0', require: false
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-json_expectations', '~> 2.2.0'
  gem 'shoulda-matchers', '~> 5.0.0'
  gem 'simplecov', '~> 0.21.2'
  gem 'webmock', '~> 3.13.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
