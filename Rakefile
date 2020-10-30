# frozen_string_literal: true

require 'rake/testtask'

CODE = 'lib/'

task :default do
  puts `rake -T`
end

desc 'run api'

task :run do
  sh 'ruby lib/script.rb'
end

desc 'run tests'
task :test do
  sh 'ruby spec/api_spec.rb'
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

  task :cop do
    sh 'rubocop -A'
  end

  task :flog do
    sh "flog #{CODE}"
  end

  task :reek do
    sh 'reek'
  end
end
