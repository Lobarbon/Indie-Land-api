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

    configure :development, :test do
      ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
    end

    configure :production do
      ENV['DATABASE_URL'] = "postgres://oirnmubrfmpnng:2ad68ce941f34c1d47f5b77421a8e6e3c24907b549f779fae82212bb903c51bb@ec2-52-3-4-232.compute-1.amazonaws.com:5432/ddcq419rdvrlil"
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
