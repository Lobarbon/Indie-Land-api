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
    plugin :public # Use public folder as location of files
    plugin :hash_routes

    plugin :render, views: './app/presentation/views/', escape: true

    # rubocop:disable Metrics/BlockLength
    route do |routing|
      routing.public
      # routing.assets
      routing.hash_routes

      routing.root do
        session[:user] ||= ''

        logger.info("User #{session[:user]} enter")
        # deal with user sessions
        user_mgr = Entity::UserManager.instance
        if user_mgr.user_exist?(session[:user])
          last_login_time = user_mgr.login_time(session[:user])
          user_mgr.update_user_login_time(session[:user])
        else
          session[:user] = user_mgr.create_new_user
          last_login_time = nil
        end

        # get updated events information from the api
        begin
          logger.info('Getting events from api')
          events = MusicEventsMapper.new.find_events
        # rubocop:disable Naming/RescuedExceptionsVariableName
        rescue StandardError => error
          logger.error(error.backtrace.join("\n"))
          flash.now[:error] = 'Error occurs at fetching api'
        end
        # rubocop:enable Naming/RescuedExceptionsVariableName

        logger.info('Writting events to database')
        Repository::For.entity(events[0]).create_many(events)

        logger.info('Finding future events from database')
        future_events = Repository::Events.future_events
        future_dates = future_events.future_dates

        logger.info('Done!')

        if future_dates.empty?
          flash.now[:error] = 'Sorry! there are some problems from the server, please come back later.'
        end

        view 'home/index', locals: {
          future_events: future_events,
          future_dates: future_dates,
          last_login_time: last_login_time
        }
      end

      routing.on 'room' do
        routing.is do
          routing.get do
            @title = 'room'
            @events = Entity::Event.find_all

            view 'room/session'
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
