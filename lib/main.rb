# frozen_string_literal: true

require_relative 'api/api.rb'
require_relative 'models/api_parser.rb'

api = Api.new
sports_api = Api::SportsApi.new

sports_data_parser = SportsDataParser.new(api.get(sports_api.baskeball_url))
sports_data_parser.parse_baseketball_data.save
