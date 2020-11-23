# frozen_string_literal: true

require 'roda'
require 'yaml'
require 'econfig'
require 'delegate'

module IndieLand
  # Configuration for the App
  class App < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    use Rack::Session::Cookie, secret: config.SESSION_SECRET

    configure :development, :test, :app_test do
      ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
    end

    configure :app_test do
      require_relative '../spec/helpers/vcr_helper.rb'
      VcrHelper.setup
      VcrHelper.insert
    end

    configure :production do
      # Set DATABASE_URL env var on production platform
    end

    configure do
      require 'sequel'

      @db = Sequel.connect(ENV['DATABASE_URL'])
      def self.db
        @db
      end
    end
  end
end
