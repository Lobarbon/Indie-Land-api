# frozen_string_literal: false

require_relative '../helpers/spec_helper'
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
      @tickets = IndieLand::MinistryOfCulture::TicketsMapper.new.find_tickets
      @events = IndieLand::MinistryOfCulture::MusicEventsMapper.new.find_events
    end

    it 'HAPPY: should be able to save events from Api to database' do
      IndieLand::Repository::For.entity(@tickets[0]).create_many(@tickets)
      rebuilts = IndieLand::Repository::For.entity(@events[0]).create_many(@events)
      _(rebuilts.length).must_equal(@events.length)
      # _(rebuilts).must_equal(@events)

      rebuilts.zip(@events).each do |rebuilt, event|
        _(rebuilt.event_id).wont_be_nil
        _(rebuilt.event_uid).must_equal(event.event_uid)
        _(rebuilt.event_name).must_equal(event.event_name)
        _(rebuilt.event_website).must_equal(event.event_website)
        _(rebuilt.event_ticket_website).must_equal(event.event_ticket_website)
        _(rebuilt.description).must_equal(event.description)
        _(rebuilt.sale_website).must_equal(event.sale_website)
        _(rebuilt.source).must_equal(event.source)
        _(rebuilt.sessions).wont_be_empty

        rebuilt.sessions.zip(event.sessions).each_with_index do |sessions, idx|
          rebuilt_session, session = sessions
          _(rebuilt_session.session_id).must_equal(idx)
          _(rebuilt_session.event_id).wont_be_nil
          _(rebuilt_session.start_time).must_equal(session.start_time)
          _(rebuilt_session.end_time).must_equal(session.end_time)
          _(rebuilt_session.address).must_equal(session.address)
          _(rebuilt_session.place).must_equal(session.place)
          _(rebuilt_session.ticket_price).must_equal(session.ticket_price)
        end
      end
    end

    it 'HAPPY: should get the same results even if we are trying to write data into db twice' do
      rebuilts = IndieLand::Repository::For.entity(@events[0]).create_many(@events)
      rebuilts_twice = IndieLand::Repository::For.entity(@events[0]).create_many(@events)

      _(rebuilts.length).must_equal(rebuilts_twice.length)
      rebuilts.zip(rebuilts_twice).each do |rebuilt, rebuilt_twice|
        rebuilt.sessions.zip(rebuilt_twice.sessions).each do |rebuilt_session, rebuilt_session_twice|
          _(rebuilt_session.session_id).must_equal(rebuilt_session_twice.session_id)
          _(rebuilt_session.event_id).must_equal(rebuilt_session_twice.event_id)
          _(rebuilt_session.start_time).must_equal(rebuilt_session_twice.start_time)
          _(rebuilt_session.end_time).must_equal(rebuilt_session_twice.end_time)
          _(rebuilt_session.address).must_equal(rebuilt_session_twice.address)
          _(rebuilt_session.place).must_equal(rebuilt_session_twice.place)
          _(rebuilt_session.ticket_price).must_equal(rebuilt_session_twice.ticket_price)
        end
      end
    end

    it 'HAPPY: should get the same results using Events.find_id' do
      rebuilts = IndieLand::Repository::For.entity(@events[0]).create_many(@events)
      find_result = IndieLand::Repository::For.entity(@events[0]).find_id(rebuilts[0].event_id)

      _(rebuilts[0].event_id).must_equal(find_result.event_id)
      _(rebuilts[0].event_name).must_equal(find_result.event_name)
      _(rebuilts[0].event_website).must_equal(find_result.event_website)
      _(rebuilts[0].event_ticket_website).must_equal(find_result.event_ticket_website)
      _(rebuilts[0].description).must_equal(find_result.description)
      _(rebuilts[0].sale_website).must_equal(find_result.sale_website)
      _(rebuilts[0].source).must_equal(find_result.source)
      _(rebuilts[0].sessions).must_equal(find_result.sessions)
    end

    it 'HAPPY: should get the sorted date array using Events.future_events.future_dates' do
      IndieLand::Repository::For.entity(@events[0]).create_many(@events)
      future_dates = IndieLand::Repository::Events.future_events.future_dates

      _(future_dates).wont_be_empty

      # the elements should be instance of Date
      future_dates.each do |date|
        _(date).must_be_instance_of(Date)
      end

      # check if future_dates is sorted
      future_dates[1..].each_with_index do |date, idx|
        _(date > future_dates[idx]).must_equal(true)
      end
    end

    it 'HAPPY: should get the brief hash using Events.future_events.events_on_that_date' do
      IndieLand::Repository::For.entity(@events[0]).create_many(@events)
      future_events = IndieLand::Repository::Events.future_events
      future_dates = future_events.future_dates

      future_dates.each do |date|
        brief_hashes = future_events.events_on_this_date(date)

        brief_hashes.each do |brief_hash|
          _(brief_hash[:event_id].class).must_equal(Integer)
          _(brief_hash[:event_name].class).must_equal(String)
          _(brief_hash[:session_id].class).must_equal(Integer)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
