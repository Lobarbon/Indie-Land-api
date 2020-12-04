  
# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'future_day_representer'

module IndieLand
  module Representer
    # Represents list of projects for API output
    class FutureDaysList < Roar::Decorator
      include Roar::JSON

      collection :futureDays, extend: Representer::FutureDay,
                            class: Response::OpenStructWithLinks
    end
  end
end