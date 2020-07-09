source 'https://rubygems.org'
ruby '2.7.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rails', '~> 6.0.3'

# WebServer
gem 'puma', '~> 4.3'
gem 'rack-cors', '~> 1.1.1'

# Graphql
gem 'graphql', '~> 1.11.1'
gem 'graphql-batch', '~> 0.4.3'

# Database
gem 'pg', '~> 1.2.3'
gem 'redis', '~> 4.2.1'

# Environment variables
gem 'dotenv-rails', '~> 2.7.5'

# Authentication
gem 'jwt', '~> 2.2.1'

# Encryption
gem 'bcrypt', '~> 3.1.13'

# Monitoring errors
gem 'graphiql-rails', '~> 1.7.0'
gem 'sentry-raven', '~> 3.0.0'

group :development, :test do
  gem 'bullet', '~> 6.1.0'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'faker', '~> 2.13.0'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'annotate', '~> 3.1.1'
  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'reek', '~> 6.0.1', require: false
  gem 'rubocop', '~> 0.87.1', require: false
  gem 'rubocop-rails', '~> 2.6.0', require: false
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-json_expectations', '~> 2.2.0'
  gem 'shoulda-matchers', '~> 4.3.0'
  gem 'simplecov', '~> 0.18.5'
  gem 'webmock', '~> 3.8.3'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
