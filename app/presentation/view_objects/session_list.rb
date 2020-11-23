# frozen_string_literal: true

require_relative 'session'

# hello
module Views
  # View for sessions entity
  class SessionsList
    def initialize(sessions)
      @sessions = sessions.map.with_index { |session, i| Session.new(session, i) }
    end

    def each(&block)
      @future_events.each(&block)
    end
  end

  def any?
    @future_events.any?
  end
end
