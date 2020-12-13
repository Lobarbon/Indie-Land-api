# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }
# ruby '2.7.2'

# PRESENTATION LAYER
gem 'multi_json'
gem 'roar'

# Web Application
gem 'erubi', '~> 1.5' # Template syntax
gem 'puma', '~> 3.11' # a multi-threaded, multi-processing server
gem 'rack', '~> 2.2.3' # 2.3 will fix delegateclass bug
gem 'roda', '~> 3.8' # web app framework

# Caching
gem 'rack-cache'
gem 'redis'
gem 'redis-rack-cache'

# Type validation
gem 'dry-struct', '~> 1.3'
gem 'dry-types', '~> 1.4'

# Controllers and services
gem 'dry-monads'
gem 'dry-transaction'
gem 'dry-validation'

# Networking
gem 'http', '~>4.0'

# Utilities
gem 'econfig', '~>2.1' # easily configure
gem 'rack-test' # can also be used to diagnose production
gem 'rake', '~>13.0' # we can say that rake is Ruby's makefile
gem 'travis'

# Object-Relational Mapping
gem 'sequel', '~>5.38' # ORM lib

group :test do
  # Testing
  gem 'minitest', '~>5.0'
  gem 'minitest-rg', '~>5.0'
  gem 'simplecov', '~>0'
  gem 'vcr', '~> 6.0'
  gem 'webmock', '~> 3.0'

  # Code Quality, Getting the latest version is fine
  gem 'flog', '~> 4.6'
  gem 'reek', '~> 6.0'
  gem 'rubocop', '~> 1.0'
end

group :development do
  # Utilities
  gem 'pry' # a debugging sandbox

  # Local database
  gem 'database_cleaner', '~>1.8'
  gem 'sqlite3', '~> 1.4'

  # display pretty db records
  gem 'hirb', '~> 0.7'

  # hirb-unicode will hurt the latest version of rubocop
  # because they depend on the different version of 'unicode-desplay_width'
  # gem 'hirb-unicode', '~> 0.0.5'

  gem 'rerun', '~> 0.13'
end

group :production do
  gem 'pg', '~> 1.2.3'
end
