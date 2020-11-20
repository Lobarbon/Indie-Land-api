# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module IndieLand
  module Entity
    # Domain entity for an Event
    class Event < Dry::Struct
      include Dry.Types

      attribute :event_id, Strict::Integer.optional
      attribute :event_uid, Strict::String
      attribute :event_name, Strict::String
      attribute :event_website, Strict::String
      attribute :description, Strict::String.optional
      attribute :sale_website, Strict::String
      attribute :source, Strict::String
      attribute :sessions, Strict::Array.of(Session)

      def to_attr_hash
        # exclude event_id and sessions
        # for event_id, just let database generate an id for each event
        # for sessions, we will save them into another table
        to_hash.reject { |key, _| %i[event_id sessions].include? key }
      end

      def to_brief_hash
        { event_id: event_id, event_name: event_name }
      end

      def future_hold_dates(today)
        sessions
          .map(&:date)
          .select { |date| date >= today }
      end

      def event_on_this_date(date)
        target_session = sessions.select { |session| session.hold_on_this_date?(date) }
        return nil if target_session.empty?

        to_brief_hash.merge(target_session.first.to_brief_hash)
      end
    end
  end
end
