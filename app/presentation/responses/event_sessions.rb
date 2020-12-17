# frozen_string_literal: true

module IndieLand
  module Response
    # List of future events
    EventSessions = Struct.new(
      :event_id,
      :event_name,
      :event_website,
      :event_ticket_website,
      :description,
      :sale_website,
      :source,
      :sessions
    )
  end
end
