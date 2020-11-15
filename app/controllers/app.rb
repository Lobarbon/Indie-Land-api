# frozen_string_literal: true

require 'roda'
require 'net/http'
require 'json'

# Routing entry
module IndieLand
  # Main routing rules
  class App < Roda
    plugin :render, views: './app/views/', escape: true
    plugin :assets, path: './app/views/assets', css: ['main-style.css', 'navbar.css', 'circular.css'], js: ['circletype.min.js', 'scroll_event.js', 'scroll_circular.js']
    plugin :hash_routes
    plugin :halt
    # Use public folder as location of files
    plugin :public

    route do |routing|
      routing.public
      routing.assets
      routing.hash_routes

      routing.root do
        @future_events = IndieLand::Repository::Events.future_events
        @future_dates = @future_events.future_dates
        view 'home/index'
      end

      routing.on 'room' do
        routing.is do
          routing.get do
            @title = 'room'
            @events = IndieLand::Repository::For.klass(IndieLand::Entity::Event).find_all
            view 'room/session'
          end
        end
      end
    end
  end
end
