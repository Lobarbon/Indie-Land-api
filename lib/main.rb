# frozen_string_literal: true

require 'fileutils'

require_relative 'apis/sports_api.rb'
require_relative 'apis/music_api.rb'
require_relative 'parsers/basketball_parser.rb'
require_relative 'parsers/indie_music_parser.rb'

SAVE_DIR = './spec/fixtures'
SPORTS_RESULT = 'sports_result.yaml'
MUSIC_RESULT = 'music_result.yaml'

def run_sports
  sports_api = SportsApi.new
  basketball_json = sports_api.basketball_json

  basketball_json_parser = BasketballJsonParser.new(basketball_json)
  basketball_data = basketball_json_parser.to_data

  save(SAVE_DIR, SPORTS_RESULT, YAML.dump(basketball_data))
end

def run_music
  music_api = MusicApi.new
  music_json = music_api.indie_music_json

  music_json_parser = IndieMusicJsonParser.new(music_json)
  music_data = music_json_parser.to_data

  save(SAVE_DIR, MUSIC_RESULT, YAML.dump(music_data))
end

def save(dir, file_name, data)
  FileUtils.mkdir_p(dir) unless File.directory?(dir)
  File.write(File.join(dir, file_name), data)
end

run_sports
run_music
