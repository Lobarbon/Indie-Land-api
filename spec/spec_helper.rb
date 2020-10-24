# frozen_string_literal: true

# NOTICE: Please ensure simplecov is required at the top of this file
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'

require 'vcr'
require 'webmock'

require_relative '../lib/api'
require_relative '../lib/parsers/indie_music_parser'

CONFIG = 'https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=5'
WRONG_CONFIG = 'https://cloud.culture.tw/frontsite/trans/do?method=doFindTypeJ&category=5'
CORRECT = YAML.safe_load(File.read('spec/fixtures/music_result.yaml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'indie_music_api'