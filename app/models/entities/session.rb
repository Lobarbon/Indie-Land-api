# frozen_string_literal: false

module IndieLand
  module Entity
    # Domain entity for activity detail info
    class Session < Dry::Struct
      include Dry.Types

      attribute :start_time,  Strict::String
      attribute :end_time,    Strict::String
      attribute :address,     Strict::String.optional
      attribute :place, Strict::String.optional
    end
  end
end
