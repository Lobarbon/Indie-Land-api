# frozen_string_literal: false

require_relative 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'VCR' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    # We do not have any token
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes, match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Test entities' do
    describe 'Test session' do
      it 'should not raise errors' do
        _(proc do
          IndieLand::Entity::Session.new(start_time: '10/1', end_time: '10/31', address: 'HsinChu', place: 'Delta Hall')
          IndieLand::Entity::Session.new(start_time: '10/1', end_time: '10/31', address: nil, place: 'Delta Hall')
          IndieLand::Entity::Session.new(start_time: '10/1', end_time: '10/31', address: 'HsinChu', place: nil)
        end).must_be_silent
      end
    end

    describe 'Test event' do
      it 'should not raise errors' do
        _(proc do
          session = IndieLand::Entity::Session.new(
            start_time: '10/1', end_time: '10/31', address: 'HsinChu', place: 'Delta Hall'
          )
          IndieLand::Entity::Event.new(
            event_name: 'my music concert', website: 'https://www.test.com', sessions: [session]
          )
        end).must_be_silent
      end
    end
  end

  describe 'Test indie music api' do
    it 'Happy: should work without errors' do
      _(proc do
        IndieLand::MusicApi.new.data
      end).must_be_silent
    end
  end

  describe 'Test response class' do
    it 'Happy: should work without errors' do
      _(proc do
        IndieLand::Response.new(HTTP.get(URL))
      end).must_be_silent
    end

    it 'Sad: should raise exception on incorrect api' do
      _(proc do
        IndieLand::Response.new(HTTP.get(WRONG_URL))
      end).must_raise IndieLand::Response::Errors::NotFound
    end
  end

  describe 'Test mappers' do
    before do
      @events = IndieLand::Mapper.new.find_events
    end

    it 'should not return an empty list' do
      _(@events).wont_be_empty
    end

    it 'should return a list with Event' do
      @events.each do |event|
        _(event).must_be_instance_of IndieLand::Entity::Event
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
