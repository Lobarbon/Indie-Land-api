# frozen_string_literal: true

require 'logger'
require 'singleton'

module IndieLand
  # Logger module for our applications
  class AppLogger
    include Singleton

    def initialize
      @logger = Logger.new($stdout)
      @logger.level = Logger::INFO
    end

    def get
      @logger
    end
  end
end
