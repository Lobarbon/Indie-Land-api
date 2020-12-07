# frozen_string_literal: false

require_relative '../helpers/spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'Test mappers' do
  VcrHelper.setup
  DatabaseHelper.setup_database_cleaner

  before do
    VcrHelper.insert
  end

  after do
    VcrHelper.eject
  end

  describe 'Test mappers' do
    before do
      @events = IndieLand::MinistryOfCulture::MusicEventsMapper.new.find_events
    end

    it 'should not return an empty list' do
      _(@events).wont_be_empty
    end

    it 'should return a list of Event' do
      @events.each do |event|
        _(event).must_be_instance_of IndieLand::Entity::Event
      end
    end

    it 'should have sessions in each Event' do
      @events.each do |event|
        event.sessions.each do |session|
          _(session).must_be_instance_of IndieLand::Entity::Session
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
