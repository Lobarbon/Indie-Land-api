# frozen_string_literal: true

require 'yaml'

# Config is a class to parse config file
class Config
  def initialize
    @path = 'lib_2/config/secrets.yaml'
    @data = YAML.safe_load(File.read(@path))
  end

  def sports
    @sports = @data['sports_api']
  end
end
