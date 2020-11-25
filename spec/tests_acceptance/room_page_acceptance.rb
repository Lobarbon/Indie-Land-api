# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/room_page'
require_relative 'pages/home_page'

# rubocop:disable Metrics/BlockLength
describe 'Roompage Acceptance Tests' do
  include PageObject::PageFactory

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

  describe 'Roompage' do
    it '(HAPPY) should go to the event room page with correct id and title' do
      # GIVEN: user has requested and created a project
      visit HomePage do |page|
        @title = page.first_event_element.text
        page.first_event_element.click
        url = page.url
        /(?<id>\d+$)/=~ url
        @index = id
      end

      # WHEN: user goes to the room page
      visit(RoomPage, using_params: { id: @index }) do |page|
        # THEN: they should see the event details
        _(page.url).must_include 'room'
        _(page.url).must_include @index
      end
    end

    # it 'HAPPY: should be able to see sessions of the events' do
    #   # TODO
    # end

    # it 'HAPPY: should see number of likes' do
    #   # TODO
    # end

    # it 'HAPPY: should be able to leave comments' do
    #   # TODO
    # end
  end
end
# rubocop:enable Metrics/BlockLength
