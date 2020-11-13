# frozen_string_literal: false

require_relative 'session'

module IndieLand
  module Entity
    # Domain entity for activity
    class Event < Dry::Struct
      include Dry.Types

      attribute :database_id, Strict::Integer.optional
      attribute :unique_id, Strict::String
      attribute :event_name, Strict::String
      attribute :main_website, Strict::String
      attribute :ticket_website, Strict::String.optional
      attribute :website_platform, Strict::String.optional
      attribute :description, Strict::String.optional
      attribute :sessions, Strict::Array.of(Session)

      def to_attr_hash
        # exclude event_id and sessions
        # for event_id, just let database generate an id for each event
        # for sessions, we will save them into another table
        to_hash.reject { |key, _| %i[database_id sessions].include? key }
      end
    end
  end
end
