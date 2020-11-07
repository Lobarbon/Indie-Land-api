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
            first_name = routing.params['first_name'].capitalize
            last_name = routing.params['last_name'].capitalize
            @msg = "Not fun #{first_name} #{last_name} hahahah!!"
            view 'room/index'
          end
          routing.get do
            @title = 'room'
            @msg = 'Go back to post your name!'
            view 'room/index'
          end
        end
      end
    end
  end
end
