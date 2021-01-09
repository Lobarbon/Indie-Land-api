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
    class LikeEvent
      include Dry::Transaction

      step :like_an_event

      private

      QUEUE_ERR_MSG = 'Error occurs at sending message to the queue'
      PROCESSING_MSG = 'Processing the like message'

      def like_an_event(input)
        input.logger.info('Sending like message to the queue')

        send_msg(input)

        Failure(Response::ApiResult.new(status: :processing, message: PROCESSING_MSG))
      rescue StandardError => e
        input.logger.error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :processing, message: QUEUE_ERR_MSG))
      end

      def send_msg(input)
        Response::QueueMsg.new(input.event_id, '').then do |queue_msg_response|
          Messaging::Queue.new(App.config.MSG_QUEUE_URL, App.config)
                          .send(Representer::QueueMsg.new(queue_msg_response).to_json)
        end
      end
    end
  end
end
