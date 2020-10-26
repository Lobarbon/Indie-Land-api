# frozen_string_literal: false

module Lobarbon
  module Entity
    # Domain entity for activity detail info
    class ActivityInfo < Dry::Struct
      include Dry.Types

      attribute :start_time,  Strict::String
      attribute :end_time,    Strict::String
      attribute :address,     Strict::String.optional
      attribute :location,    Strict::String.optional
    end
  end
end
