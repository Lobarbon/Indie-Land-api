# frozen_string_literal: true

require 'fileutils'

require_relative 'api.rb'

SAVE_DIR = 'spec/fixtures'
SPORTS_RESULT = 'sports_result.yaml'
MUSIC_RESULT = 'music_result.yaml'

def run_sports
  sports_api = Lobarbon::SportsApi.new
  sports_tables = sports_api.basketball_tables

  save(SAVE_DIR, SPORTS_RESULT, YAML.dump(sports_tables))
end

def run_music
  music_api = Lobarbon::MusicApi.new
  music_activities = music_api.indie_music_activities

  save(SAVE_DIR, MUSIC_RESULT, YAML.dump(music_activities))
end

def save(dir, file_name, data)
  FileUtils.mkdir_p(dir) unless File.directory?(dir)
  File.write(File.join(dir, file_name), data)
end

run_sports
run_music
