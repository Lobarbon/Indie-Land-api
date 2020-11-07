# frozen_string_literal: true

require 'vcr'
require 'webmock'

class VcrHelper
  CASSETTES_FOLDER = 'spec/fixtures/cassettes'
  CASSETTE_FILE = 'indie_music_api'

  def self.setup
    VCR.configure do |c|
      c.cassette_library_dir = CASSETTES_FOLDER
      c.hook_into :webmock
    end
    # We don't have to filter the sensitive data
  end

  def self.insert
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes, match_requests_on: %i[method uri headers]
  end

  def self.eject
    VRC.eject_cassette
  end
end
