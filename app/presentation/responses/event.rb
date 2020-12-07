# frozen_string_literal: true

module IndieLand
  module Response
    # List of future events
    Event = Struct.new(:event_id, :event_name, :session_id)
  end
end
