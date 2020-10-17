# frozen_string_literal: true

require 'http'
require './lib/config.rb'

# MusicApi
class MusicApi
  def initialize
    @config = Config.new
  end

  def indie_music_json
    HTTP.get(@config.indie_music_url)
  end
end
