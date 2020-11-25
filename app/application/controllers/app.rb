# frozen_string_literal: true

require 'roda'
require 'net/http'
require 'json'

# Routing entry
module IndieLand
  # Main routing rules
  class App < Roda
    logger = AppLogger.instance.get

    plugin :halt
    plugin :flash
    plugin :public, root: 'app/presentation/public' # Use public folder as location of files
    plugin :hash_routes

    plugin :render, views: './app/presentation/views/', escape: true
    plugin :assets, path: './app/presentation/assets'
    # rubocop:disable Metrics/BlockLength
    route do |routing|
      routing.public
      # routing.assets
      routing.hash_routes

      routing.root do
        session[:user] ||= ''

        logger.info("User #{session[:user]} enter")
        # deal with user sessions
        result = Service::TrackUser.new.call(user_id: session[:user], logger: logger)
        if result.failure?
          flash.now[:error] = result.failure
          login_number = 0
        else
          session[:user] = result.value![:user_id]
          login_number = result.value![:login_number]
        end

        result = Service::GetEvents.new.call(logger: logger)
        flash.now[:error] = result.failure if result.failure?

        future_events = result.value!

        viewable_events = Views::FutureEvents.new(future_events)
        view 'home/index', locals: {
          future_events: viewable_events,
          login_number: login_number
        }
      end

      routing.on 'room' do
        routing.get Integer do |id|
          event_sessions = IndieLand::Repository::Events.find_id(id)
          viewable_sessions = Views::EventSessionsList.new(event_sessions)

          view 'room/index', locals: { sessions: viewable_sessions }
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
