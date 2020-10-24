# frozen_string_literal: true

require 'fileutils'
require 'yaml'

require_relative 'api'

@save_dir = 'spec/fixtures'
@music_result = 'music_result.yaml'

def run_music
  music_api = Lobarbon::MusicApi.new
  music_activities = music_api.indie_music_activities

  save(YAML.dump(music_activities))
end

def save(data)
  FileUtils.mkdir_p(@save_dir) unless File.directory?(@save_dir)
  File.write(File.join(@save_dir, @music_result), data)
end

run_music
