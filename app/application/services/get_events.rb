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
    class GetEvents
      include Dry::Transaction

      step :find_events_from_api
      step :write_back_to_database
      step :find_future_events

      def find_events_from_api(input)
        input[:logger].info('Getting events from api')
        events = MusicEventsMapper.new.find_events
        Success(events: events, logger: input[:logger])
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at fetching api')
      end

      def write_back_to_database(input)
        input[:logger].info('Writting events back to database')
        Repository::For.entity(input[:events][0]).create_many(input[:events])

        Success(logger: input[:logger])
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at writing data back')
      end

      def find_future_events(input)
        input[:logger].info('Finding future events from database')
        future_events = Repository::Events.future_events

        Success(future_events)
      rescue StandardError => e
        input[:logger].error(e.backtrace.join("\n"))
        Failure('Error occurs at finding future events')
      end
    end
  end
end
