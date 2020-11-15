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
      ENV['DATABASE_URL'] = "postgres://oirgquiaawxouw:803ff9af8e81e7d28f3708a6aefc3f5603a157f4b7847d4b348c21fa98df8a99@ec2-52-87-58-157.compute-1.amazonaws.com:5432/d5kpae6l2vcf"
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
