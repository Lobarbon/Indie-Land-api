# frozen_string_literal: true

require 'roda'
require 'net/http'
require 'json'

# Routing entry
module IndieLand
  # Main routing rules
  class App < Roda
    plugin :halt
    plugin :flash
    plugin :public # Use public folder as location of files
    plugin :hash_routes

    plugin :render, views: './app/presentation/views/', escape: true
    plugin :assets, path: './app/presentation/assets',
                    css: ['main-style.css', 'navbar.css', 'circular.css'],
                    js: ['circletype.min.js', 'scroll_event.js', 'scroll_circular.js']

    route do |routing|
      routing.public
      routing.assets
      routing.hash_routes

      routing.root do
        session[:history] ||= []

        # get updated events information from the api
        @events = IndieLand::MusicEventsMapper.new.find_events
        IndieLand::Repository::For.entity(@events[0]).create_many(@events)

        @future_events = IndieLand::Repository::Events.future_events
        @future_dates = @future_events.future_dates

        if @future_dates.empty?
          flash.now[:error] = 'Sorry! there are some problems in the server, please come back later.'
        else
          flash.now[:notice] = 'Welcome to Indie-Land'
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
  end
end
