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
    plugin :hash_routes
    plugin :halt

    route do |routing|
      routing.assets
      routing.hash_routes
      routing.root do
        @title = 'home'

        view 'home/index'
      end

      routing.on 'room' do
        routing.is do
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
