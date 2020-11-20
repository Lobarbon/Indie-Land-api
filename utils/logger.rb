# frozen_string_literal: true

require 'logger'

module IndieLand
  # Logger class for our applications
  class AppLogger
    @logger = Logger.new($stdout)
    @logger.level = Logger::INFO

    def self.logger
      @logger
    end
  end
end
