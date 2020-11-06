# frozen_string_literal: true

module IndieLand
    module Repository
      # Repository for Events
      class Events
        def self.find_id(id)
          rebuild_entity Database::EventOrm.first(id: id)
        end
  
        def self.find_eventnname(event_name)
          rebuild_entity Database::EventOrm.first(event_name: event_name)
        end
  
        private
  
        def self.rebuild_entity(db_record)
          return nil unless db_record
  
          Entity::Event.new(
            id:         db_record.id,
            event_name: db_record.event_name,
            website:  db_record.website
          )
        end
  
        def self.rebuild_many(db_records)
          db_records.map do |db_event|
            Events.rebuild_entity(db_event)
          end
        end
  
        def self.db_find_or_create(entity)
          Database::EventOrm.find_or_create(entity.to_attr_hash)
        end
      end
    end
  end