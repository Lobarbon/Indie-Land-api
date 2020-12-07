# frozen_string_literal: true

module IndieLand
  module Response
    # List of future events
    Session = Struct.new(
      :event_id,
      :session_id,
      :start_time,
      :end_time,
      :address,
      :place,
      :ticket_price
    )
  end
end
