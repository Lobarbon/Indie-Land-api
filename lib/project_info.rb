# frozen_string_literal: true

require_relative 'api.rb'
require_relative 'config.rb'
require_relative 'api_parser.rb'

# debug code
cfg = Config.new

basketball_api = SportsApi.new(cfg.baskeball_url)
basketball_result = basketball_api.get

parser = Parser.new(basketball_result)
parser.parse_baseketball_data
