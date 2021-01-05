# frozen_string_literal: true

require 'roda'
require 'net/http'
require 'json'
require_relative 'lib/init'

# Routing entry
module IndieLand
  # Main routing rules
  class App < Roda
    logger = AppLogger.instance.get

    plugin :halt
    plugin :flash
    plugin :all_verbs # allows DELETE and other HTTP verbs beyond GET/POST
    plugin :caching # enable reversed caching
    use Rack::MethodOverride

    # rubocop:disable Metrics/BlockLength
    route do |routing|
      # set response content type to json
      response['Content-Type'] = 'application/json'

      # GET /
      routing.root do
        message = "IndieLand API v1 at /api/v1 in #{App.environment} mode"

        result_response = Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message: message)
        )

        response.status = result_response.http_status_code

        result_response.to_json
      end

      routing.on 'api/v1' do
        routing.on 'events' do
          routing.get Integer do |event_id|
            request = Request::Event.new(
              event_id, logger
            )
            result = Service::EventSessions.new.call(request)
            Representer::For.new(result).status_and_body(response)
          end

          routing.get do
            Cache::Control.new(response).turn_on if Env.new(App).production? # cache 1 hour

            Service::Tickets.new.call(logger: logger)
            result = Service::ListEvents.new.call(logger: logger)

            Representer::For.new(result).status_and_body(response)
          end

          routing.on 'search' do
            # GET /events/search?q=eventname
            routing.get do
              request = Request::Query.new(
                routing.params, logger
              )
              result = Service::QueryEvents.new.call(request)
              Representer::For.new(result).status_and_body(response)
            end
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
