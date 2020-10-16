# frozen_string_literal: true

require 'http'
require './lib/config.rb'

# SportsApi
class SportsApi
  def initialize
    @config = Config.new
  end

  def basketball_json
    HTTP.get(@config.basketball_url)
  end
end
