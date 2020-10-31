# frozen_string_literal: false

require_relative 'session'

module IndieLand
  module Entity
    # Domain entity for activity
    class Event < Dry::Struct
      include Dry.Types

      attribute :event_name, Strict::String
      attribute :website, Strict::String
      attribute :sessions, Strict::Array.of(Session)
    end
  end
end
