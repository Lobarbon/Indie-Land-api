# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module IndieLand
  module Representer
    # Represents event information for API output
    class Session < Roar::Decorator
      include Roar::JSON

      property :startTime
      property :endTime
      property :address
      property :place
    end
  end
end
