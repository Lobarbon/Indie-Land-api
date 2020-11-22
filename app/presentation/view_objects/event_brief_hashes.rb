# frozen_string_literal: true

module Views
  # View for a single event entity
  class BriefHashes
    def initialize(brief_hash)
      @brief_hash = brief_hash
    end

    def event_id
      @brief_hash[:event_id]
    end

    def event_name
      @brief_hash[:event_name]
    end
  end
end
