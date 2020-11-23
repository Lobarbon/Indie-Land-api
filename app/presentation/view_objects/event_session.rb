# frozen_string_literal: true

module Views
  # View for a single session entity
  class Session
    def initialize(session, index = nil)
      @session = session
      @index = index
    end

    def id
      @index
    end

    def start_time
      @session.start_time
    end

    def end_time
      @session.end_time
    end

    def address
      @session.address
    end

    # :reek:NilCheck and :reek:DuplicateMethodCall
    def place
      @session.place.nil? ? @session.place : ' free la'
    end
  end
end
