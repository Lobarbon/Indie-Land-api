# frozen_string_literal: true

require 'vcr'
require 'webmock'

# Make it easy to use VCR
class VcrHelper
  CASSETTES_FOLDER = 'spec/fixtures/cassettes'
  CASSETTE_FILE = 'indie_music_api'

  def self.setup
    VCR.configure do |config|
      config.cassette_library_dir = CASSETTES_FOLDER
      config.hook_into :webmock
      config.ignore_localhost = true
    end
    # We don't have to filter the sensitive data
  end

  def self.insert
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers],
                        allow_playback_repeats: true
  end

  def self.eject
    VCR.eject_cassette
  end
end
