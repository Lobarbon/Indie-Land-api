# frozen_string_literal: true

# NOTICE: Please ensure simplecov is required at the top of this file
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'

require 'date'

require_relative '../init'

# require all helpers
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

URL = 'https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=5'
WRONG_URL = 'https://cloud.culture.tw/frontsite/trans/do?method=doFindTypeJ&category=5'

ENV['RACK_ENV'] = 'test'

# Helper methods
def homepage
  IndieLand::App.config.APP_HOST
end
