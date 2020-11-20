# frozen_string_literal: true

require 'roda'
require 'net/http'
require 'json'

# Routing entry
module IndieLand
  # Main routing rules
  class App < Roda
    logger = AppLogger.logger

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
        session[:history] ||= []

        # get updated events information from the api
        begin
          logger.info('Getting events from api')
          @events = IndieLand::MusicEventsMapper.new.find_events
        # rubocop:disable Naming/RescuedExceptionsVariableName
        rescue StandardError => error
          logger.error(error.backtrace.join("\n"))
          flash.now[:error] = 'Error occurs at fetching api'
        end
        # rubocop:enable Naming/RescuedExceptionsVariableName

        logger.info('Writting events to database')
        IndieLand::Repository::For.entity(@events[0]).create_many(@events)

        logger.info('Finding future events from database')
        @future_events = IndieLand::Repository::Events.future_events
        @future_dates = @future_events.future_dates

        logger.info('Done!')

        if @future_dates.empty?
          flash.now[:error] = 'Sorry! there are some problems from the server, please come back later.'
        else
          flash.now[:notice] = 'Welcome to Indie-Land.'
        end

        view 'home/index'
      end

      routing.on 'room' do
        routing.is do
          routing.get do
            @title = 'room'
            @events = IndieLand::Entity::Event.find_all

            view 'room/session'
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
  end
end
