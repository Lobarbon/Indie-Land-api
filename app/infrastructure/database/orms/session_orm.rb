# frozen_string_literal: true

require 'sequel'

module CodePraise
  module Database
    # Object Relational Mapper for Project Entities
    class ProjectOrm < Sequel::Model(:sessions)
      many_to_one :event,
                  class: :'IndieLand::Database::SessionOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
