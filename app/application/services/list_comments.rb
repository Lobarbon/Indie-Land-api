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
    class ListComment
      include Dry::Transaction

      step :find_comments

      private

      ERROR_MSG = 'Error occurs at finding comments'

      def find_comments(input)
        input.logger.info("Find comments of event id: #{input.event_id}")

        comments = Repository::Comments.find_all(input.event_id).to_hash
        comments_response = get_comments_response(comments)

        Success(Response::ApiResult.new(status: :ok, message: comments_response))
      rescue StandardError => e
        input.logger.error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :internal_error, message: ERROR_MSG))
      end

      def get_comments_response(comments)
        replace_comments_from_hash_to_response(comments)
        new_comments(comments)
      end

      # the method name is suck, but I didn't come up with any great idea
      def new_comments(comments)
        Response::Comments.new(event_id: comments[:event_id], comments: comments[:comments])
      end

      def replace_comments_from_hash_to_response(comments)
        comments[:comments] = comments[:comments].map do |comment|
          { event_id: comment[:event_id], comment: comment[:comment] }
        end
      end
    end
  end
end
