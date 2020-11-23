# frozen_string_literal: true

require_relative 'event_brief_hashes'

module Views
  # View for today events entity
  class TodayEvents
    def initialize(date, events)
      @events = events.map { |brief_hash| BriefHashes.new(brief_hash) }
      @date = date
    end

    def date
      @date
    end

    def each(&block)
      @events.each(&block)
    end

    def any?
      @events.any?
    end
  end
end
