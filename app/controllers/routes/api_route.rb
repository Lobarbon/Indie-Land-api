# frozen_string_literal: true

require 'date'
require 'json'

module IndieLand
  # Api routes
  class App
    hash_branch 'api' do |routing|
      @events = IndieLand::MusicEventsMapper.new.find_events
      IndieLand::Repository::For.entity(@events[0]).create_many(@events)

      routing.on 'events' do
        response['Content-Type'] = 'application/json; charset=utf-8'
        routing.on 'id' do
          routing.get Integer do |event_id|
            event = IndieLand::Repository::Events.find_id(event_id)
            event.nil? ? '' : event.to_attr_hash.to_json
          end
        end

        routing.on 'date' do
          routing.get Integer, Integer, Integer do |yy, mm, dd|
            date = Date.new(yy, mm, dd)
            future_events = IndieLand::Repository::Events.future_events
            future_events.events_on_this_date(date).to_json
          end

          routing.get do
            future_events = IndieLand::Repository::Events.future_events
            future_events.future_dates.to_json
          end
        end

        routing.get do
          @events.map(&:to_attr_hash).to_json
        end
      end
    end
  end
end
