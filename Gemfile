source 'https://rubygems.org'
ruby '2.7.2'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rails', '~> 6.0.3'

# WebServer
gem 'puma', '~> 5.1'
gem 'rack-cors', '~> 1.1.1'

# Graphql
gem 'graphql', '~> 1.11.6'
gem 'graphql-batch', '~> 0.4.3'

# Database
gem 'pg', '~> 1.2.3'
gem 'redis', '~> 4.2.5'
gem 'strong_migrations', '~> 0.7.3'

# Environment variables
gem 'dotenv-rails', '~> 2.7.6'

# Authentication
gem 'jwt', '~> 2.2.2'

# Encryption
gem 'bcrypt', '~> 3.1.16'

# Monitoring errors
gem 'graphiql-rails', '~> 1.7.0'
gem 'sentry-raven', '~> 3.1.1'

group :development, :test do
  gem 'bullet', '~> 6.1.0'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'faker', '~> 2.15.1'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'annotate', '~> 3.1.1'
  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '>= 3.0.5', '< 3.4'
  gem 'reek', '~> 6.0.2', require: false
  gem 'rubocop', '~> 1.4.2', require: false
  gem 'rubocop-rails', '~> 2.8.1', require: false
  gem 'rubocop-rspec', '~> 2.0.1', require: false
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-json_expectations', '~> 2.2.0'
  gem 'shoulda-matchers', '~> 4.4.1'
  gem 'simplecov', '~> 0.20.0'
  gem 'webmock', '~> 3.10.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
