# frozen_string_literal: true

require 'json'

module IndieLand
  class App
    hash_branch 'api' do |r|
      r.on 'music' do
        response['Content-Type'] = 'application/json; charset=utf-8'
        @events = IndieLand::MusicEventsMapper.new.find_events
        IndieLand::Repository::For.entity(@events[0]).create_many(@events)

        r.get Integer do |event_id|
          # event_id = IndieLand::Repository::For.entity(@events[0]).find_all[1].event_id
          a = IndieLand::Repository::Events.find_id(event_id)
          a.nil? ? '' : a.to_attr_hash.to_json
        end

        r.get do
          @events.map(&:to_attr_hash).to_json
        end
      end
    end
  end
end
