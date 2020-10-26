# frozen_string_literal: true

require 'roda'
require 'tilt/sass'
require 'net/http'
require 'json'

class App < Roda
  plugin :render, views: './app/views/', escape: true
  plugin :assets, path: './app/views/assets', css: ['style.css'], js: ['script.js']
  route do |r|
    r.assets
    r.get do
      @title = 'home'
      view 'home/index'
    end
  end
end
