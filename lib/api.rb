# frozen_string_literal: true

require 'http'

# SportsApi is a class to get data from Sports Lottery website
class SportsApi
  def initialize(url)
    @url = url
  end

  def get
    HTTP.get(@url)
  end
end
