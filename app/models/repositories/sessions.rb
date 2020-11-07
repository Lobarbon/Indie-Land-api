# frozen_string_literal: true

module IndieLand
  module Repository
    # Repository for Session Entities
    class Sessions
      def self.find_event_sessions(event_id)
        # SELECT * FROM `sessions`
        # WHERE (`event_id` = 'event_id')
        rebuild_many Database::SessionOrm.where(event_id: event_id)
      end

      def self.create_many(event_id, sessions)
        sessions.map do |session|
          create_one(event_id, session)
        end
      end

      def self.create_one(event_id, session)
        find_or_create session.merge(event_id: event_id)
      end

      def self.find_or_create(session)
        rebuild_entity Database::SessionOrm.find_or_create session
      end

      def self.rebuild_many(session_records)
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

      private_class_method :new, :find_or_create, :rebuild_many, :rebuild_entity
    end
  end
end
