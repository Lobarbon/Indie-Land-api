# frozen_string_literal: true

require 'dry/monads/result'
require 'base64'
require 'json'

module IndieLand
  module Request
    # Application value for the path of a requested project
    class Query
      include Dry::Monads::Result::Mixin

      def initialize(query, logger)
        @query = query
        @logger = logger
      end

      attr_reader :query, :logger

      # Use in API to parse incoming requests
      def call
        Success(
          decode(@query)
        )
      rescue StandardError
        Failure(
          Response::ApiResult.new(
            status: :bad_request,
            message: 'Event not found'
          )
        )
      end

      # Decode params
      def decode(query)
        CGI.unescape(query['q'])
      end
    end
  end
end
