# frozen_string_literal: true

require 'rake/testtask'

CODE = 'lib/'

task :default do
  puts `rake -T`
end

desc 'run console'
task :console do
  sh 'irb -r ./init.rb'
end

desc 'run api'
task :run do
  sh 'ruby spec/script.rb'
end

desc 'run tests'
task :test do
  sh 'ruby spec/api_spec.rb'
end

desc 'run app'
task :up do
  sh 'rackup'
end

namespace :vcr do
  desc 'clean cassette fixtures'
  task :clean do
    sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
      puts(ok ? 'Directory Cassettes is clean' : 'No file found in Cassettes')
    end
  end
end

namespace :check do
  desc 'run all quality checks'
  task all: %i[cop flog reek]

  desc 'run rubocop'
  task :cop do
    sh 'rubocop -A'
  end

  desc 'run flog for abc metric'
  task :flog do
    sh "flog #{CODE}"
  end

  desc 'run reek for bad smell code'
  task :reek do
    sh 'reek'
  end
end

# rubocop:disable Metrics/BlockLength
namespace :db do
  task :config do
    require 'sequel'
    require_relative 'config/environment'
    require_relative 'spec/helpers/database_helper'

    def app
      IndieLand::App
    end
  end

  desc 'Run migrations'
  task migrate: :config do
    Sequel.extension :migration
    puts "Migrating #{app.environment} database to latest"
    Sequel::Migrator.run(app.db, 'app/infrastructure/database/migrations')
  end

  desc 'Wipe records from all tables'
  task wipe: :config do
    DatabaseHelper.setup_database_cleaner
    DatabaseHelper.wipe_database
  end

  desc 'Delete dev or test database file'
  task drop: :config do
    if app.environment == :production
      puts 'Cannot remove production database!'
      return
    end
    FileUtils.rm(IndieLand::App.config.DB_FILENAME)
    puts "Deleted #{IndieLand::App.config.DB_FILENAME}"
  end
end
# rubocop:enable Metrics/BlockLength
