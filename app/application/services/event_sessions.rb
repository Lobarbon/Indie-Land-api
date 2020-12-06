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
    class EventSessions
      include Dry::Transaction

      # step :find_events_from_api
      step :find_future_event_session

      private

      MINISTRY_OF_CULTURE_API_ERR = "Error occurs at fetching Ministry of Culture's api"
      WRITE_DB_ERR = 'Error occurs at writing events back to the database'
      FINDING_EVENTS_ERR = 'Error occurs at finding events'

      # def find_events_from_api(input)
      #   input[:logger].info('Getting events from the api')
      #   events = MinistryOfCulture::MusicEventsMapper.new.find_events
      #   Success(events: events, logger: input[:logger])
      # rescue StandardError => e
      #   input[:logger].error(e.backtrace.join("\n"))
      #   Failure(Response::ApiResult.new(status: :internal_error, message: MINISTRY_OF_CULTURE_API_ERR))
      # end

      def find_future_event_session(input)
        input[:logger].info('Finding future events from the database')
        future_events = Repository::Events.find_id(input[:event_id])
        Success(Response::ApiResult.new(status: :ok, message: future_events))
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: FINDING_EVENTS_ERR))
      end
    end
  end
end
