# frozen_string_literal: true

require 'dry/monads/result'
require 'base64'
require 'json'

module IndieLand
  module Request
    # Application value for the path of a requested project
    class Comment
      include Dry::Monads::Result::Mixin

      def initialize(query, event_id, logger)
        @query = query
        @event_id = event_id
        @logger = logger
      end

      attr_reader :query, :event_id, :logger

      # Use in API to parse incoming requests
      def call
        Success(
          decode(@query)
        )
      rescue StandardError
        Failure(
          Response::ApiResult.new(
            status: :bad_request,
            message: 'Comment error'
          )
        )
      end

      # :reek:UtilityFunction
      # Decode params
      def decode(query)
        CGI.unescape(query['q'])
      end
    end
  end
end
