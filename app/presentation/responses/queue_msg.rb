# frozen_string_literal: true

module IndieLand
  module Response
    # Inform like
    QueueMsg = Struct.new(:event_id, :comment, :request_id)
  end
end
