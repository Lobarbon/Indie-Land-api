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

        event_record = Database::EventOrm.find_or_create(entity.to_attr_hash)
        # if the sessions have been saved into databse, just return
        return rebuild_entity(event_record) unless event_record.sessions.empty?

        # if the sessions have not been saved,
        # save it and find it again(Sessions will automatically associate with Event)
        Sessions.create_sessions_of_one_event(event_record, entity.sessions)
        find_id(event_record.id)
      end

      def self.rebuild_entity(event_record)
        return nil unless event_record

        Entity::Event.new(
          event_id: event_record.id,
          event_name: event_record.event_name,
          website: event_record.website,
          sessions: Sessions.rebuild_entities(event_record.sessions)
        )
      end
    end
  end
end
