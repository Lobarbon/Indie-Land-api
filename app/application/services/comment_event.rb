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
    class CommentEvent
      include Dry::Transaction

      step :comment_an_event

      private

      QUEUE_ERR_MSG = 'Error occurs at sending message to the queue'
      PROCESSING_MSG = 'Processing the comment'

      def comment_an_event(input)
        input[:request].logger.info('Sending comment to the queue')

        send_msg(input[:request], input[:request_id])

        Failure(Response::ApiResult.new(status: :processing, message: { request_id: input[:request_id] }))
      rescue StandardError => e
        input[:request].logger.error(e.backtrace.join("\n"))
        Failure(Response::ApiResult.new(status: :processing, message: QUEUE_ERR_MSG))
      end

      def send_msg(input, request_id)
        Response::QueueMsg.new(input.event_id, input.call.value!, request_id).then do |queue_msg_response|
          Messaging::Queue.new(App.config.MSG_QUEUE_URL, App.config)
                          .send(Representer::QueueMsg.new(queue_msg_response).to_json)
        end
      end
    end
  end
end
