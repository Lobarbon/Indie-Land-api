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
    class ListLikes
      include Dry::Transaction

      step :find_comments

      private

      ERROR_MSG = 'Error occurs at get likes'

      # rubocop:disable Metrics/AbcSize
      def find_comments(input)
        input.logger.info("Find likes of event id: #{input.event_id}")

        like_hash = Repository::Events.find_id(input.event_id).to_like_hash
        likes_response = Response::Like.new(like_hash[:event_id], like_hash[:like_num])

        Success(Response::ApiResult.new(status: :ok, message: likes_response))
      rescue StandardError => e
        input.logger.error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: ERROR_MSG))
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
