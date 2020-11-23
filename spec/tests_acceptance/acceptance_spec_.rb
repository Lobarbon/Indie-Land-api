# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/home_page'

# rubocop:disable Metrics/BlockLength
describe 'Acceptance Tests' do
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

  describe 'Homepage' do
    it 'HAAPY: should see the date not in the past' do
      # GIVEN: user do nothing

      # WHEN: they visit the home page
      visit HomePage do |page|
        # THEN: they should see today or future day at first
        _(page.future_date?).must_equal true
      end
    end

    it 'HAPPY: should has a url on each event' do
      # GIVEN: user do nothing

      # WHEN: they visit the home page
      visit HomePage do |page|
        # THEN: user should have a link on events
        _(page.first_event_element.present?).must_equal true
      end
    end

    it 'HAAPY: should be able to click the event' do
      # GIVEN: user is on the home page
      visit HomePage do |page|
        # WHEN: they click an event
        page.first_event_element.click
        # THEN: they should go to event's page
        page.url.include? 'events'
      end
    end

    it 'HAAPY: should be able to click the github button' do
      # GIVEN: user is on the home page
      visit HomePage do |page|
        # WHEN: they click the github button
        page.github_button_element.click
        # THEN: they should go to our github project's page
        _(page.url).must_equal GITHUB
      end
    end

    # it 'HAAPY: should be able to click the tag button' do
    #   # TODO
    # end

    # it 'HAPPY: should be able to like each event' do
    #   # TODO
    # end
  end

  describe 'Event page' do
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
