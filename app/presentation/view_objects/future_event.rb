# frozen_string_literal: true

module Views
  # View for a single event entity
  class Event
    def initialize(_date)
      @event = event
      @index = index
    end

    def entity
      @event
    end
  end
end
