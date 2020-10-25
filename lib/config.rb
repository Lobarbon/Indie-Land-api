# frozen_string_literal: true

require 'yaml'

# Config is a class to parse config file
class Config
  def initialize
    @path = 'config/secrets.yaml'
    @data = YAML.safe_load(File.read(@path))
  end

  def indie_music_url
    @data['music_api']['indie_music_url']
  end
end
