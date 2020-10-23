# frozen_string_literal: true

require 'http'
require_relative 'config.rb'
require_relative './parsers/indie_music_parser.rb'

module Lobarbon
  # Define bahaviors of all api classes
  class Response < SimpleDelegator
    module Errors
      class NotFound < StandardError; end
    end

    attr_reader :response

    HTTP_ERROR = {
      404 => Errors::NotFound
    }.freeze

    def initialize(response)
      @response = response
    end

    def check_error
      raise HTTP_ERROR[@response.code] if HTTP_ERROR.keys.include?(response.code)
    end
  end

  # MusicApi
  class MusicApi
    def initialize
      @config = Config.new
    end

    def indie_music_activities
      result = indie_music_json
      Parsers::IndieMusicJsonParser.new(result).to_data
    end

    private

    def indie_music_json
      res = Response.new(HTTP.get(@config.indie_music_url))

      res.check_error
      res.response
    end
  end
end
