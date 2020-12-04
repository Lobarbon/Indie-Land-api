# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module IndieLand
  module Representer
    # Represents event information for API output
    class futureEvent < Roar::Decorator
      include Roar::JSONs

      property :startTime
      property :endTime
      property :address
      property :place
    end
  end
end
