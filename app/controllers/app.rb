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
    plugin :public
    # Use /path/to/app/static as location of files
    opts[:root] = '/path/to/app'
    plugin :public, root: 'static'

    plugin :hash_routes
    plugin :halt

    route do |routing|
      routing.public
      routing.assets
      routing.hash_routes
      routing.root do
        @title = 'home'

        view 'home/index'
      end
      routing.on(:static) do
        routing.public
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
