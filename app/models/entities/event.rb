# frozen_string_literal: false

require_relative 'session'

module IndieLand
  module Entity
    # Domain entity for activity
    class Event < Dry::Struct
      include Dry.Types

      attribute :event_id, Strict::Integer.optional
      attribute :event_name, Strict::String
      attribute :website, Strict::String
      attribute :sessions, Strict::Array.of(Session)

      def to_attr_hash
        # exclude event_id and sessions
        # for event_id, just let database generate an id for each event
        # for sessions, we will save them into another table
        to_hash.reject { |key, _| %i[event_id sessions].include? key }
      end
    end
  end
end
