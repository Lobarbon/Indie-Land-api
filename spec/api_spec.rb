# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'json'
require 'http'
# require_relative '../lib/apis/sport_api'
# require_relative '../lib/apis/nusic_api'

USERNAME = 'soumyaray'.freeze
PROJECT_NAME = 'YPBT-app'.freeze
CONFIG = YAML::load_file('./config/secrets.yaml')
BASKETBALL_URL = CONFIG['sports_api']['basketball_url']
# INDIE_MUSIC_URL = CONFIG['music_api']['indie_music_url']
SPORT_YAML = YAML::load_file( './spec/fixtures/sports_result.yaml')
# MUSIC_YAML = YAML::load_file('spec/fixtures/nusic_results.yml')

describe 'Tests API library' do
  describe 'Sport information' do

    it 'should match the number of records' do
        @sport_json = JSON.parse(HTTP.get(BASKETBALL_URL))
        _(SPORT_YAML.count).must_equal([11,@sport_json['result']['r']].min)
    end

    it 'should match the first record' do
        first_record = @sport_json['result']['d'][0]
        _(SPORT_YAML[0]['time']).must_equal first_record['kdt']
        _(SPORT_YAML[0]['country']).must_equal first_record['cn'][0]
        _(SPORT_YAML[0]['league']).must_equal first_record['ln'][0]
        _(SPORT_YAML[0]['away_team']).must_equal first_record['atn'][0]
        _(SPORT_YAML[0]['host_team']).must_equal first_record['htn'][0]
    end
  
  end

  describe 'Music information' do
    # TODO
  end
end