# frozen_string_literal: true

require 'yaml'

require_relative 'api.rb'
require_relative 'config.rb'

# debug code
cfg = Config.new
basketball_api = SportsApi.new(cfg.baskeball_url)
puts basketball_api.get
