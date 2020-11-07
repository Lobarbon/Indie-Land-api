# frozen_string_literal: true

# NOTICE: Please ensure simplecov is required at the top of this file
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'

require_relative '../init'

URL = 'https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=5'
WRONG_URL = 'https://cloud.culture.tw/frontsite/trans/do?method=doFindTypeJ&category=5'

ENV['RACK_ENV'] = 'test'
