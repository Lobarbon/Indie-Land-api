# frozen_string_literal: true

module IndieLand
  module Response
    # List of future events
    DailyEvents = Struct.new(:date, :daily_events)
  end
end
