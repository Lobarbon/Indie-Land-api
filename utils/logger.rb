# frozen_string_literal: true

require 'logger'

module IndieLand
  # Logger class for our applications
  class AppLogger
    @logger = Logger.new($stdout)
    @logger.level = Logger::INFO

    # make AppLogger Singleton
    private_class_method :new

    def self.logger
      @logger
    end
  end
end
