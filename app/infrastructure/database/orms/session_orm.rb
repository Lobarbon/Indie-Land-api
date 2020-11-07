# frozen_string_literal: true

require 'sequel'

module IndieLand
  module Database
    # Object Relational Mapper for Session Entities
    class SessionOrm < Sequel::Model(:sessions)
      many_to_one :event,
                  class: :'IndieLand::Database::SessionOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
