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
    class ListEvents
      include Dry::Transaction

      step :find_events_from_api
      step :write_back_to_database
      step :find_future_events

      private

      MINISTRY_OF_CULTURE_API_ERR = "Error occurs at fetching Ministry of Culture's api"
      WRITE_DB_ERR = 'Error occurs at writing events back to the database'
      FINDING_EVENTS_ERR = 'Error occurs at finding events'

      def find_events_from_api(input)
        input[:logger].info('Getting events from the api')
        events = MinistryOfCulture::MusicEventsMapper.new.find_events
        Success(events: events, logger: input[:logger])
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: MINISTRY_OF_CULTURE_API_ERR))
      end

      def write_back_to_database(input)
        input[:logger].info('Writting events back to the database')
        Repository::For.entity(input[:events][0]).create_many(input[:events])

        Success(logger: input[:logger])
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: WRITE_DB_ERR))
      end

      def find_future_events(input)
        input[:logger].info('Finding future events from the database')
        future_events = Repository::Events.future_events

        range_events = get_range_events(future_events)
        Response::RangeEvents.new(range_events)
                             .then do |range_events_response|
          Success(Response::ApiResult.new(status: :ok, message: range_events_response))
        end
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: FINDING_EVENTS_ERR))
      end

      def get_range_events(future_events)
        future_dates = future_events.future_dates

        future_dates.map do |date|
          brief_hashes = future_events.events_on_this_date(date)
          Response::DailyEvents.new(date, get_daily_events(brief_hashes))
        end
      end

      def get_daily_events(brief_hashes)
        brief_hashes.map do |event_hash|
          Response::Event.new(event_hash[:event_id], event_hash[:event_name], event_hash[:session_id])
        end
      end
    end
  end
end
