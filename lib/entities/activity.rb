# frozen_string_literal: false

require_relative 'activity_info'

module Lobarbon
  module Entity
    # Domain entity for activity
    class Activity < Dry::Struct
      include Dry.Types

      attribute :title,   Strict::String
      attribute :website, Strict::String
      attribute :infos,   Strict::Array.of(ActivityInfo)
    end
  end
end
