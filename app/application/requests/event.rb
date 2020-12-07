# frozen_string_literal: true

module IndieLand
  module Request
    # Application value for the path of a requested project
    class Event
      def initialize(event_id, logger)
        @event_id = event_id
        @logger = logger
      end

      attr_reader :event_id, :logger
    end
  end
end
