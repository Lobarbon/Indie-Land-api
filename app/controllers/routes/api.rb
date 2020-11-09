# frozen_string_literal: true

require 'json'

module IndieLand
  class App
    hash_branch 'api' do |r|
      r.is do
        @events = IndieLand::MusicEventsMapper.new.find_events
        IndieLand::Repository::For.entity(@events[0]).create_many(@events)
        @events.map(&:to_attr_hash).to_json
      end
    end
  end
end
