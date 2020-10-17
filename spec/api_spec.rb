# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'json'
require 'http'
# require_relative '../lib/apis/sport_api'
# require_relative '../lib/apis/nusic_api'
require_relative '../lib/parsers/basketball_parser.rb'
# require_relative '../lib/parsers/indle_music_parser.rb'

USERNAME = 'soumyaray'.freeze
PROJECT_NAME = 'YPBT-app'.freeze
CONFIG = YAML.load_file('config/secrets.yaml')
BASKETBALL_URL = CONFIG['sports_api']['basketball_url']
MUSIC_URL = CONFIG['music_api']['indie_music_url']

describe 'Tests API library' do
  before do
    `ruby lib/main.rb`
    SPORT_YAML = YAML.load_file('spec/fixtures/sports_result.yaml')
    MUSIC_YAML = YAML.load_file('spec/fixtures/music_results.yml')
    @sport_json = JSON.parse(HTTP.get(BASKETBALL_URL))
    @music_json = JSON.parse(HTTP.get(MUSIC_URL))
  end

  describe 'Sport information' do
    it 'Happy : should match the number of records' do
      _(SPORT_YAML.count).must_equal([11, @sport_json['result']['r']].min)
    end

    it 'Happy : should match the first record' do
      first_record = @sport_json['result']['d'][0]
      _(SPORT_YAML[0]['time']).must_equal first_record['kdt']
      _(SPORT_YAML[0]['country']).must_equal first_record['cn'][0]
      _(SPORT_YAML[0]['league']).must_equal first_record['ln'][0]
      _(SPORT_YAML[0]['away_team']).must_equal first_record['atn'][0]
      _(SPORT_YAML[0]['host_team']).must_equal first_record['htn'][0]
    end

    it 'SAD: parser should raise exception when given null json' do
      parsed_data = BasketballJsonParser.new('{}').to_data
      _(parsed_data).must_equal []
    end
  end

  describe 'Music information' do
    # TODO
  end

  after do
    `rm ./spec/fixtures/*.yaml > /dev/null 2>&1;`
  end
end
