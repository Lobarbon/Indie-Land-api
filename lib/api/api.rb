# frozen_string_literal: true

require 'http'
require './lib_2/include/config.rb'
require_relative 'sports.rb'
# Api data
class Api < Config
  attr_reader :data
  def initialize
    @data = Config.new
  end

  def get(url)
    HTTP.get(url)
  end
  # SportsApi
  class SportsApi
    include Sports

    def initialize
      @sports_api = Config.new.sports
    end
  end
end
