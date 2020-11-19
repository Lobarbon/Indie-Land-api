# frozen_string_literal: true

require 'roda'
require 'yaml'
require 'econfig'

module IndieLand
  # Configuration for the App
  class App < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    plugin :sessions, secret: config.SESSION_SECRET

    configure :development, :test do
      ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
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
