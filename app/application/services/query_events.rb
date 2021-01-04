# frozen_string_literal: true

require 'dry/transaction'

module IndieLand
  module Service
    # A service to return eventsessions
    # :reek:InstanceVariableAssumption
    # :reek:TooManyStatements
    # :reek:UncommunicativeVariableName
    # :reek:FeatureEnvy
    # :reek:DuplicateMethodCall
    # :reek:UtilityFunction
    class QueryEvents
      include Dry::Transaction

      step :validate_query
      step :find_query_events

      private

      FINDING_EVENTS_ERR = 'Error occurs at query events'

      def validate_query(input)
        input.logger.info('Validate query')
        query = input.call
        if query.success?
          Success(input)
        else
          Failure(query.failure)
        end
      end

      def find_query_events(input)
        input.logger.info('Finding match events from the database')
        query_events = Repository::Events.query_events(input.decode(input.query))
        query_events = get_query_events(query_events)
        Response::QueryEvents.new(query_events)
                             .then do |query_events_response|
          Success(Response::ApiResult.new(status: :ok, message: query_events_response))
        end
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: FINDING_EVENTS_ERR))
      end

      # def get_range_events(future_events)
      #   future_dates = future_events.future_dates

      #   future_dates.map do |date|
      #     brief_hashes = future_events.events_on_this_date(date)
      #     Response::DailyEvents.new(date, get_daily_events(brief_hashes))
      #   end
      # end

      def get_query_events(query_events)
        query_events.map do |event_hash|
          Response::QueryEvent.new(event_hash[:event_id], event_hash[:event_name])
        end
      end
    end
  end
end
