# frozen_string_literal: true

require 'http'
require_relative 'config.rb'
require_relative 'parsers.rb'

module Lobarbon
  # Define bahaviors of all api classes
  class AbstractApi
    module Errors
      class NotFound < StandardError; end
    end

    HTTP_ERROR = {
      404 => Errors::NotFound
    }.freeze

    def initialize
      @config = Config.new
    end

    protected

    def successful?(result)
      HTTP_ERROR.keys.include?(result.code) ? false : true
    end
  end

  # SportsApi
  class SportsApi < AbstractApi
    def initialize
      super
    end

    def basketball_tables
      result = basketball_json
      Parsers::BasketballJsonParser.new(result).to_data
    end

    private

    def basketball_json
      result = HTTP.get(@config.basketball_url)

      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end
  end

  # MusicApi
  class MusicApi < AbstractApi
    def initialize
      super
    end

    def indie_music_activities
      result = indie_music_json
      Parsers::IndieMusicJsonParser.new(result).to_data
    end

    private

    def indie_music_json
      result = HTTP.get(@config.indie_music_url)

      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end
  end
end
