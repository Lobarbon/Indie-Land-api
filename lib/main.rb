# frozen_string_literal: true

require_relative 'apis/sports_api.rb'
require_relative 'parsers/basketball_parser.rb'

SAVE_DIR = './spec/fixtures'
SAVE_FILE = 'sports_result.yaml'

sports_api = SportsApi.new
basketball_json = sports_api.basketball_json

basketball_json_parser = BasketballJsonParser.new(basketball_json)
basketball_data = basketball_json_parser.to_data

# store data to disks
FileUtils.mkdir_p(SAVE_DIR) unless File.directory?(SAVE_DIR)
File.write(File.join(SAVE_DIR, SAVE_FILE), YAML.dump(basketball_data))
