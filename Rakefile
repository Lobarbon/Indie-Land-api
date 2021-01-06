# frozen_string_literal: true

require 'rake/testtask'

CODE = 'app/'

task :default do
  puts `rake -T`
end

desc 'run console'
task :console do
  sh 'irb -r ./init.rb'
end

desc 'run api'
task :api do
  sh 'ruby script/api_script.rb'
end

desc 'Run unit and integration tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.warning = false
end

desc 'Keep rerunning tests upon changes'
task :respec do
  sh "rerun -c 'rake spec' --ignore 'coverage/*'"
end

desc 'Keep restarting web app upon changes'
task :rerack do
  sh "rerun -c 'rackup -p 9090' --ignore 'coverage/*'"
end

desc 'run api'
task :up do
  sh 'rackup -p 9090'
end

desc 'run api in test mode'
task :test do
  sh 'RACK_ENV=test rackup -p 9090'
end

# NOTE: run `rake run:test` in another process
desc 'Run acceptance tests'
Rake::TestTask.new(:spec_accept) do |t|
  t.pattern = 'spec/tests_acceptance/*_acceptance.rb'
  t.warning = false
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

  desc 'run all quality checks without auto-correct'
  task ci_all: %i[kind_cop flog reek]

  desc 'run rubocop'
  task :cop do
    sh 'rubocop -A'
  end

  desc 'run rubocop without auto-correct'
  task :kind_cop do
    sh 'rubocop'
  end

  desc 'run flog for abc metric'
  task :flog do
    sh "flog #{CODE}"
  end

  desc 'run reek for bad smell code'
  task :reek do
    sh "reek #{CODE}"
  end
end

namespace :run do
  task :dev do
    sh 'rerun -c "rackup -p 9090"'
  end

  task :test do
    sh 'RACK_ENV=test rackup -p 9090'
  end
end

# rubocop:disable Metrics/BlockLength
namespace :db do
  task :config do
    require 'sequel'
    require_relative 'config/environment'

    @app = IndieLand::App
  end

  desc 'Run migrations'
  task migrate: :config do
    Sequel.extension :migration
    puts "Migrating #{@app.environment} database to latest"
    Sequel::Migrator.run(@app.db, 'app/infrastructure/database/migrations')
  end

  desc 'Wipe records from all tables'
  task wipe: :config do
    require_relative 'spec/helpers/database_helper'
    DatabaseHelper.setup_database_cleaner
    DatabaseHelper.wipe_database
  end

  desc 'Delete dev or test database file'
  task drop: :config do
    if @app.environment == :production
      puts 'Cannot remove production database!'
      return
    end
    FileUtils.rm(@app.config.DB_FILENAME)
    puts "Deleted #{@app.config.DB_FILENAME}"
  end
end
# rubocop:enable Metrics/BlockLength

# rubocop:disable Metrics/BlockLength
namespace :cache do
  task :config do
    require_relative 'config/environment'
    require_relative 'app/infrastructure/cache/init'
    @app = IndieLand::App
  end

  namespace :list do
    desc 'Directory listing of local dev cache'
    task :dev do
      puts 'Lists development cache'
      list = `ls _cache`
      puts 'No local cache found' if list.empty?
      puts list
    end

    desc 'Lists production cache'
    task production: :config do
      puts 'Finding production cache'
      keys = IndieLand::Cache::Client.new(@app.config).keys
      puts 'No keys found' if keys.none?
      keys.each { |key| puts "Key: #{key}" }
    end
  end

  namespace :wipe do
    desc 'Delete development cache'
    task :dev do
      puts 'Deleting development cache'
      sh 'rm -rf _cache/*'
    end

    desc 'Delete production cache'
    task production: :config do
      print 'Are you sure you wish to wipe the production cache? (y/n) '
      if $stdin.gets.chomp.downcase == 'y'
        puts 'Deleting production cache'
        wiped = IndieLand::Cache::Client.new(@app.config).wipe
        wiped.each_key { |key| puts "Wiped: #{key}" }
      end
    end
  end
end

namespace :queues do
  task :config do
    require 'aws-sdk-sqs'
    require_relative 'config/environment' # load config info
    @api = IndieLand::App

    @sqs = Aws::SQS::Client.new(
      access_key_id: @api.config.AWS_ACCESS_KEY_ID,
      secret_access_key: @api.config.AWS_SECRET_ACCESS_KEY,
      region: @api.config.AWS_REGION
    )
  end

  desc 'Create SQS queue for worker'
  task :create => :config do
    puts "Environment: #{@api.environment}"
    @sqs.create_queue(queue_name: @api.config.MSG_QUEUE)

    q_url = @sqs.get_queue_url(queue_name: @api.config.MSG_QUEUE).queue_url
    puts 'Queue created:'
    puts "  Name: #{@api.config.MSG_QUEUE}"
    puts "  Region: #{@api.config.AWS_REGION}"
    puts "  URL: #{q_url}"
  rescue StandardError => e
    puts "Error creating queue: #{e}"
  end

  desc 'Report status of queue for worker'
  task :status => :config do
    q_url = @sqs.get_queue_url(queue_name: @api.config.MSG_QUEUE).queue_url

    puts "Environment: #{@api.environment}"
    puts 'Queue info:'
    puts "  Name: #{@api.config.MSG_QUEUE}"
    puts "  Region: #{@api.config.AWS_REGION}"
    puts "  URL: #{q_url}"
  rescue StandardError => e
    puts "Error finding queue: #{e}"
  end

  desc 'Purge messages in SQS queue for worker'
  task :purge => :config do
    q_url = @sqs.get_queue_url(queue_name: @api.config.MSG_QUEUE).queue_url
    @sqs.purge_queue(queue_url: q_url)
    puts "Queue #{queue_name} purged"
  rescue StandardError => e
    puts "Error purging queue: #{e}"
  end
end

namespace :worker do
  namespace :run do
    desc 'Run the background message worker in development mode'
    task :dev => :config do
      sh 'RACK_ENV=development bundle exec shoryuken -r ./workers/message_worker.rb -C ./workers/shoryuken_dev.yml'
    end

    desc 'Run the background message worker in testing mode'
    task :test => :config do
      sh 'RACK_ENV=test bundle exec shoryuken -r ./workers/message_worker.rb -C ./workers/shoryuken_test.yml'
    end

    desc 'Run the background message worker in production mode'
    task :production => :config do
      sh 'RACK_ENV=production bundle exec shoryuken -r ./workers/message_worker.rb -C ./workers/shoryuken.yml'
    end
  end
end

desc 'Run application console (irb)'
task :console do
  sh 'irb -r ./init'
end

namespace :vcr do
  desc 'delete cassette fixtures'
  task :wipe do
    sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
      puts(ok ? 'Cassettes deleted' : 'No cassettes found')
    end
  end
end

# rubocop:enable Metrics/BlockLength
