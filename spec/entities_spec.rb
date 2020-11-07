# frozen_string_literal: false

require_relative 'spec_helper'
# rubocop:disable Metrics/BlockLength
describe 'Test entities class' do
  describe 'Test session' do
    it 'should not raise errors if session_id is nil' do
      _(proc do
        IndieLand::Entity::Session.new(
          session_id: nil, event_id: 1, start_time: '10/1', end_time: '10/31', address: 'HsinChu', place: 'Delta Hall'
        )
      end).must_be_silent
    end

    it 'should not raise errors if event_id is nil' do
      _(proc do
        IndieLand::Entity::Session.new(
          session_id: 1, event_id: nil, start_time: '10/1', end_time: '10/31', address: 'HsinChu', place: 'Delta Hall'
        )
      end).must_be_silent
    end

    it 'should not raise errors if address is nil' do
      _(proc do
        IndieLand::Entity::Session.new(
          session_id: 1, event_id: 100, start_time: '10/1', end_time: '10/31', address: nil, place: 'Delta Hall'
        )
      end).must_be_silent
    end

    it 'should not raise errors if place is nil' do
      _(proc do
        IndieLand::Entity::Session.new(
          session_id: 1, event_id: 100, start_time: '10/1', end_time: '10/31', address: 'HsinChu', place: nil
        )
      end).must_be_silent
    end

    it 'should raise errors if start_time is nil' do
      _(proc do
        IndieLand::Entity::Session.new(
          session_id: 1, event_id: 100, start_time: nil, end_time: '10/31', address: 'HsinChu', place: 'Delta Hall'
        )
      end).must_raise Dry::Struct::Error
    end

    it 'should raise errors if end_time is nil' do
      _(proc do
        IndieLand::Entity::Session.new(
          session_id: 1, event_id: 100, start_time: '10/1', end_time: nil, address: 'HsinChu', place: 'Delta Hall'
        )
      end).must_raise Dry::Struct::Error
    end
  end

  describe 'Test event' do
    before do
      @sessions = [IndieLand::Entity::Session.new(
        session_id: 1, event_id: 100, start_time: '10/1', end_time: '10/31', address: 'HsinChu', place: 'Delta Hall'
      )]
    end

    it 'should not raise errors if event_id is nil' do
      _(proc do
        IndieLand::Entity::Event.new(
          event_id: nil, event_name: 'my music concert', website: 'https://www.test.com', sessions: @sessions
        )
      end).must_be_silent
    end

    it 'should raise errors if event_name is nil' do
      _(proc do
        IndieLand::Entity::Event.new(
          event_id: 1, event_name: nil, website: 'https://www.test.com', sessions: @sessions
        )
      end).must_raise Dry::Struct::Error
    end

    it 'should raise errors if website is nil' do
      _(proc do
        IndieLand::Entity::Event.new(
          event_id: 1, event_name: 'my music concert', website: nil, sessions: @sessions
        )
      end).must_raise Dry::Struct::Error
    end

    it 'should not raise errors if sessions is an empty array' do
      _(proc do
        IndieLand::Entity::Event.new(
          event_id: 1, event_name: 'my music concert', website: 'https://www.test.com', sessions: []
        )
      end).must_be_silent
    end
  end
end
# rubocop:enable Metrics/BlockLength
