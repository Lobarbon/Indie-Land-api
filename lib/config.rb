# frozen_string_literal: true

require 'yaml'

# Config is a class to parse config file
class Config
  def initialize
    @path = 'config/secrets.yaml'
    @data = YAML.safe_load(File.read(@path))
  end

  def basketball_url
    @data['sports_api']['basketball_url']
  end
end
