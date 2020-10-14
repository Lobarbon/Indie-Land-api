# frozen_string_literal: true

require 'yaml'
require 'http'

CONFIG_PATH = '../config/secrets.yaml'

# Config is a class to parse config file
class Config
  def initialize(path = './config/secrets.yaml')
    @data = YAML.safe_load(File.read(path))
    @url = @data['sports_api']
  end

  def baskeball_url
    @url['basketball_url']
  end
end

# SportsApi is a class to get data from Sports Lottery website
class SportsApi
  def initialize(config)
    @config = config
  end

  def basketball
    HTTP.get(@config.baskeball_url)
  end
end

# BasketballParser is a class to parse basketball information from sports api
class BasketballParser
  def initialize(text)
    @text = text
  end

  # TODO: Parse game information and save into the disk
end

# debug code
sport_api = SportsApi.new(Config.new)
puts sport_api.basketball
