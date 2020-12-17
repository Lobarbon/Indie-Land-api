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
    class EventSessions
      include Dry::Transaction

      # step :find_events_from_api
      step :find_event_sessions

      private

      MINISTRY_OF_CULTURE_API_ERR = "Error occurs at fetching Ministry of Culture's api"
      WRITE_DB_ERR = 'Error occurs at writing events back to the database'
      FINDING_EVENTS_ERR = 'Error occurs at finding events'

      def find_event_sessions(input)
        input.logger.info('Finding future events from the database')
        event_sessions = Repository::Events.find_id(input.event_id).to_hash
        event_sessions_response = get_event_sessions_response(event_sessions)
        Success(Response::ApiResult.new(status: :ok, message: event_sessions_response))
      rescue StandardError => e
        input.logger.error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: FINDING_EVENTS_ERR))
      end

      def get_event_sessions_response(event_sessions)
        replace_sessions_from_hash_to_response(event_sessions)
        new_event_sessions(event_sessions)
      end

      def new_event_sessions(event_sessions)
        Response::EventSessions.new(
          event_sessions[:event_id],
          event_sessions[:event_name],
          event_sessions[:event_website],
          event_sessions[:event_ticket_website],
          event_sessions[:description],
          event_sessions[:sale_website],
          event_sessions[:source],
          event_sessions[:sessions]
        )
      end

      def replace_sessions_from_hash_to_response(event_sessions)
        # Replace original array of hash to array of Struct
        event_sessions[:sessions] = event_sessions[:sessions].map do |session|
          Response::Session.new(session[:event_id], session[:session_id],
                                session[:start_time], session[:end_time],
                                session[:address], session[:place],
                                session[:ticket_price])
        end
      end
    end
  end
end
