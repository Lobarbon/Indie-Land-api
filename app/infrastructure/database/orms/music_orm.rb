# frozen_string_literal: true

require 'sequel'

module IndieLand
  module Database
    # Object Relational Mapper for Session Entities
    class SessionOrm < Sequel::Model(:sessions)
      many_to_one :event,
                  class: :'IndieLand::Database::EventOrm'

      plugin :timestamps, update_on_create: true
    end

    # Object Relational Mapper for Event Entities
    class EventOrm < Sequel::Model(:events)
      one_to_many :event_sessions,
                  class: :'IndieLand::Database::SessionOrm',
                  key: :event_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(event_info)
        first(event_name: event_info[:event_name]) || create(event_info)
      end
    end
  end
end
