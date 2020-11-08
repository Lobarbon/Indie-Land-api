# frozen_string_literal: true

require 'roda'
require 'net/http'
require 'json'

# Routing entry
module IndieLand
  # Main routing rules
  class App < Roda
    plugin :render, views: './app/views/', escape: true
    plugin :assets, path: './app/views/assets', css: ['style.css'], js: ['script.js']
    plugin :halt

    route do |routing|
      routing.assets
      routing.root do
        @title = 'home'
        view 'home/index'
      end

      routing.on 'room' do
        routing.is do

          routing.post do
            @title = 'room'
            # Get event from API
            @events = IndieLand::MusicEventsMapper.new.find_events

            # # Add event to database
            IndieLand::Repository::For.entity(@events[0]).create_many(@events)

            # Redirect viewer to project page
            # routing.redirect "project/#{project.owner.username}/#{project.name}"
            # @events = IndieLand::Repository::For.klass(IndieLand::Entity::Event).find_all
            
            view 'room/index'
          end

          routing.get do
            @title = 'room'
            @events = IndieLand::Repository::For.klass(IndieLand::Entity::Event).find_all

            view 'room/index'
          end
        end
      end
    end
  end
end
