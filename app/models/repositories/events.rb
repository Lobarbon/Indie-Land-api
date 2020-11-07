# frozen_string_literal: true

module IndieLand
  module Repository
    # Repository for Events
    class Events
      def self.find_id(event_id)
        rebuild_entity Database::EventOrm.first(id: event_id)
      end

      def self.create_many(entities)
        raise TypeError('Please pass an array of entities.') unless entities.is_a? Array

        entities.map do |entity|
          create_one(entity)
        end
      end

      def self.create_one(entity)
        raise TypeError('Please pass an entity or you could use create_many.') if entity.is_a? Array

        find_or_create(entity)
      end

      def self.find_or_create(entity)
        event_record = Database::EventOrm.find_or_create(entity.to_attr_hash)
        unless event_record.to_hash.key?(:sessions)
          sessions = entity.sessions.map(&:to_attr_hash)
          event_record[:sessions] = Sessions.create_many(event_record.id, sessions)
        end
        rebuild_entity event_record
      end

      def self.rebuild_entity(event_record)
        return nil unless event_record

        Entity::Event.new(
          event_id: event_record.id,
          event_name: event_record.event_name,
          website: event_record.website,
          sessions: event_record[:sessions]
        )
      end

      private_class_method :new, :find_or_create, :rebuild_entity
    end
  end
end
