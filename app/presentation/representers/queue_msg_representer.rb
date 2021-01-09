# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents Like message
module IndieLand
  module Representer
    # Represent a like message
    class QueueMsg < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :event_id
      property :comment

      private

      def event_id
        represented.event_id
      end

      def comment
        represented.comment
      end
    end
  end
end
