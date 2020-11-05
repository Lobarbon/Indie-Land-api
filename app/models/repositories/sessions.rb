# frozen_string_literal: true

module IndieLand
  module Repository
    # Repository for Session Entities
    class Sessions
      def self.all
        Database::SessionOrm.all.map { |db_session| rebuild_entity(db_session) }
      end

      def self.find_full_name(event_name)
        # SELECT * FROM `sessions` LEFT JOIN `events`
        # ON (`events`.`id` = `sessoins`.`event_id`)
        # WHERE (`event_name` = 'event_name')
        db_session = Database::SessionOrm
                     .left_join(:events, id: :event_id)
                     .where(event_name: event_name)
                     .first
        rebuild_entity(db_session)
      end

      def self.find(entity)
        find_origin_id(entity.origin_id)
      end

      def self.find_id(id)
        db_record = Database::SessionOrm.first(id: id)
        rebuild_entity(db_record)
      end

      def self.find_origin_id(origin_id)
        db_record = Database::SessionOrm.first(origin_id: origin_id)
        rebuild_entity(db_record)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Session.new(
          db_record.to_hash.merge(
            event: Sessions.rebuild_entity(db_record.event)
          )
        )
      end
    end
  end
end
