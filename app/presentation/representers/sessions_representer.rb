# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'session_representer'

module IndieLand
  module Representer
    # Represents event information for API output
    class Sessions < Roar::Decorator
      include Roar::JSON

      collection :sessions, extend: Representer::Session, class: OpenStruct
    end
  end
end
