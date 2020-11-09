# frozen_string_literal: false

module IndieLand
  module Entity
    # Domain entity for activity detail info
    class Session < Dry::Struct
      include Dry.Types

      attribute :session_id, Strict::Integer.optional
      attribute :event_id, Strict::Integer.optional
      attribute :start_time,  Strict::String
      attribute :end_time,    Strict::String
      attribute :address,     Strict::String.optional
      attribute :place, Strict::String.optional

      def to_attr_hash
        to_hash
      end
    end
  end
end
