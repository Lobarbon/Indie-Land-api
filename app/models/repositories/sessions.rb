# frozen_string_literal: true

module IndieLand
  module Repository
    # Repository for Session Entities
    class Sessions
      def self.create_one(event_record, session_entities)
        session_entities.map(&:to_attr_hash).each do |session|
          session[:event_id] = event_record.id
          event_record.add_session session
        end
      end

      def self.rebuild_entities(session_records)
        return nil unless session_records

        session_records.map do |session_record|
          rebuild_entity session_record
        end
      end

      def self.rebuild_entity(session_record)
        return nil unless session_record

        Entity::Session.new(
          session_id: session_record.id,
          event_id: session_record.event_id,
          start_time: session_record.start_time,
          end_time: session_record.end_time,
          address: session_record.address,
          place: session_record.place
        )
      end
    end
  end
end
