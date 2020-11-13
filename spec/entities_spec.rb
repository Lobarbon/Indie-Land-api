# frozen_string_literal: false

require_relative 'spec_helper'
# rubocop:disable Metrics/BlockLength
describe 'Test entities class' do
  describe 'Test session' do
    it 'should not raise errors if optional fields are nil' do
      _(proc do
        IndieLand::Entity::Session.new(
          session_id: nil,
          event_id: nil,
          start_time: '10/1',
          end_time: '10/31',
          price: nil,
          address: nil,
          place: nil
        )
      end).must_be_silent
    end

    it 'should raise errors if mandotory fields are nil' do
      _(proc do
        IndieLand::Entity::Session.new(
          session_id: nil,
          event_id: nil,
          start_time: nil,
          end_time: '10/31',
          price: nil,
          address: nil,
          place: nil
        )
        IndieLand::Entity::Session.new(
          session_id: nil,
          event_id: nil,
          start_time: '10/1',
          end_time: nil,
          price: nil,
          address: nil,
          place: nil
        )
      end).must_raise Dry::Struct::Error
    end
  end

  describe 'Test event' do
    before do
      @sessions = [IndieLand::Entity::Session.new(
        session_id: nil,
        event_id: nil,
        start_time: '10/1',
        end_time: '10/31',
        price: nil,
        address: nil,
        place: nil
      )]
    end

    it 'should not raise errors if optional fields are nil' do
      _(proc do
        IndieLand::Entity::Event.new(
          database_id: nil,
          unique_id: '5eeb588cd083a33abc1abb9d',
          event_name: 'my music concert',
          main_website: 'https://www.test.com',
          ticket_website: nil,
          website_platform: nil,
          description: nil,
          sessions: @sessions
        )
      end).must_be_silent
    end

    it 'should raise errors if mandatory fields are nil' do
      _(proc do
        IndieLand::Entity::Event.new(
          database_id: nil,
          unique_id: nil,
          event_name: 'my music concert',
          main_website: 'https://www.test.com',
          ticket_website: nil,
          website_platform: nil,
          description: nil,
          sessions: @sessions
        )
        IndieLand::Entity::Event.new(
          database_id: nil,
          unique_id: '5eeb588cd083a33abc1abb9d',
          event_name: nil,
          main_website: 'https://www.test.com',
          ticket_website: nil,
          website_platform: nil,
          description: nil,
          sessions: @sessions
        )
        IndieLand::Entity::Event.new(
          database_id: nil,
          unique_id: '5eeb588cd083a33abc1abb9d',
          event_name: 'my music concert',
          main_website: nil,
          ticket_website: nil,
          website_platform: nil,
          description: nil,
          sessions: @sessions
        )
      end).must_raise Dry::Struct::Error
    end
  end
end
# rubocop:enable Metrics/BlockLength
