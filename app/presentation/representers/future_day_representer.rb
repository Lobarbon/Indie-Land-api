# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'future_event_representer'

# Represents essential Repo information for API output
module IndieLand
  module Representer
    # Represent a Project entity as Json
    class FutureDay < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :date
      collection :future_events, extend: Representer::FutureEvent, class: OpenStruct

      link :self do
        "#{App.config.API_HOST}/api/v1/future_days/#{future_day}"
      end

      private

      def project_name
        represented.future_day
      end
    end
  end
end
