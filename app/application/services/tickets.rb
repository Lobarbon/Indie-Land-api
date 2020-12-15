# frozen_string_literal: true

require 'dry/transaction'

module IndieLand
  module Service
    # Analyzes contributions to a project
    # :reek:InstanceVariableAssumption
    # :reek:TooManyStatements
    # :reek:UncommunicativeVariableName
    # :reek:FeatureEnvy
    # :reek:DuplicateMethodCall
    # :reek:UtilityFunction
    class Tickets
      include Dry::Transaction

      step :find_events_from_kktix_api
      step :write_back_to_ticket_database

      private

      KKTIX_API_ERR = "Error occurs at fetching Kktix's api"
      WRITE_TICKET_DB_ERR = 'Error occurs at writing tickets back to the database'

      def find_events_from_kktix_api(input)
        input[:logger].info('Getting tickets from the kktix api')
        tickets = MinistryOfCulture::TicketsMapper.new.find_tickets
        Success(tickets: tickets, logger: input[:logger])
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: KKTIX_API_ERR))
      end

      def write_back_to_ticket_database(input)
        input[:logger].info('Writting tickets back to the database')
        Repository::For.entity(input[:tickets][0]).create_many(input[:tickets])
        Success(logger: input[:logger])
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: WRITE_TICKET_DB_ERR))
      end
    end
  end
end
