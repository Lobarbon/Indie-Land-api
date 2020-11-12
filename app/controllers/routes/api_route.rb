# frozen_string_literal: true

require 'json'

module IndieLand
  # Api routes
  class App
    hash_branch 'api' do |routing|
      routing.on 'music' do
        response['Content-Type'] = 'application/json; charset=utf-8'
        @events = IndieLand::MusicEventsMapper.new.find_events
        IndieLand::Repository::For.entity(@events[0]).create_many(@events)

        routing.get Integer do |event_id|
          event = IndieLand::Repository::Events.find_id(event_id)
          event.nil? ? '' : event.to_attr_hash.to_json
        end

        routing.get do
          @events.map(&:to_attr_hash).to_json
        end
      end
    end
  end
end
