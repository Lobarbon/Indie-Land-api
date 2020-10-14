# frozen_string_literal: true

require 'yaml'

CONFIG_PATH = './config/secrets.yaml'

# Config is a class to parse config file
class Config
  def initialize(path = CONFIG_PATH)
    @data = YAML.safe_load(File.read(path))
    @url = @data['sports_api']
  end

  def baskeball_url
    @url['basketball_url']
  end
end
