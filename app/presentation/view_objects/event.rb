# frozen_string_literal: true

require_relative 'event_brief_hashes'

module Views
  # View for a single event entity
  class Event
    def initialize(date, event)
      @event = event.map { |brief_hash| BriefHashes.new(brief_hash) }
      @date = date
    end

    def date
      @date
    end

    def each(&block)
      @event.each(&block)
    end

    def any?
      @event.any?
    end
  end
end
