# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/database_helper'
require_relative 'helpers/vcr_helper'
require 'headless'
require 'watir'

describe 'Acceptance Tests' do
  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    @headless.destroy
  end

  describe 'Homepage' do
    it 'HAPPY: should be able to see events sorted by date' do
      # TODO
    end
    it 'HAPPY: should be able to click the tag button' do
      # TODO
    end
    it 'HAPPY: should be able to like each event' do
      # TODO
    end
    it 'HAPPY: should has a url on each event' do
      # TODO
    end
  end

  describe 'Event page' do
    it 'HAPPY: should be able to see sessions of the events' do
      # TODO
    end
    it 'HAPPY: should see number of likes' do
      # TODO
    end
  end
end
