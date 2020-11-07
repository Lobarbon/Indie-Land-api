# frozen_string_literal: false

require_relative 'spec_helper'
# rubocop:disable Metrics/BlockLength
describe 'Integration Tests of IndeMusic Api and Database' do
  VcrHelper.setup
  DatabaseHelper.setup_database_cleaner

  before do
    VcrHelper.insert
  end

  after do
    VcrHelper.eject
  end

  describe 'Retrieve and store events' do
    before do
      DatabaseHelper.wipe_database
      @events = IndieLand::MusicEventsMapper.new.find_events
    end

    it 'HAPPY: should be able to save events from Api to database' do
      rebuilts = IndieLand::Repository::For.entity(@events[0]).create_many(@events)
      _(rebuilts.length).must_equal(@events.length)

      rebuilts.zip(@events).each do |rebuilt, event|
        _(rebuilt.event_id).wont_be_nil
        _(rebuilt.event_name).must_equal(event.event_name)
        _(rebuilt.website).must_equal(event.website)
        _(rebuilt.sessions).wont_be_empty

        rebuilt.sessions.each do |session|
          _(session.session_id).wont_be_nil
          _(session.event_id).must_equal(rebuilt.event_id)
          _(session.start_time).wont_be_nil
          _(session.end_time).wont_be_nil
        end
      end
    end

    it 'HAPPY: should get the same results even if we are trying to write data into db twice' do
      rebuilts = IndieLand::Repository::For.entity(@events[0]).create_many(@events)
      rebuilts_twice = IndieLand::Repository::For.entity(@events[0]).create_many(@events)

      _(rebuilts.length).must_equal(rebuilts_twice.length)
      rebuilts.zip(rebuilts_twice).each do |rebuilt, rebuilt_twice|
        _(rebuilt.sessions.length).must_equal(rebuilt_twice.sessions.length)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
