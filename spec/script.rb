# frozen_string_literal: true

require 'fileutils'
require 'yaml'

require_relative '../init'

@save_dir = 'spec/fixtures'
@music_result = 'music_result.yaml'

def run_music
  events = IndieLand::Mapper.new.find_events
  save(YAML.dump(events))
end

def save(data)
  FileUtils.mkdir_p(@save_dir) unless File.directory?(@save_dir)
  File.write(File.join(@save_dir, @music_result), data)
end

run_music
