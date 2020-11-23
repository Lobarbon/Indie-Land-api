# frozen_string_literal: true

module Views
  # View for a single session entity
  class Session
    def initialize(session, index = nil)
      @session = session
      @index = index
    end

    def session_id
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

    def place
        @session.place
    end
  end
end
