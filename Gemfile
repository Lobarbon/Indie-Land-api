# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }
# ruby '2.7.2'

# Web Application
gem 'econfig'
gem 'erubi', '~> 1.5'           # Template syntax
gem 'puma', '~> 3.11'
gem 'roda', '~> 3.8'
gem 'slim', '~> 3.0'
gem 'tilt', '~> 2.0.6'          # Templating engine

# Validation
gem 'dry-struct', '~> 1.3'
gem 'dry-types', '~> 1.4'

# Networking
gem 'http', '~>4.0'

# Testing
gem 'minitest', '~>5.0'
gem 'minitest-rg', '~>5.0'
gem 'simplecov', '~>0'
gem 'vcr', '~> 6.0'
gem 'webmock', '~> 3.0'

# Code Quality
gem 'flog'
gem 'reek'
gem 'rubocop'

# Utilities
gem 'pry'
gem 'rake'

# Database
gem 'hirb'
gem 'sequel'

group :development, :test do
  gem 'database_cleaner'
  gem 'sqlite3'
end
