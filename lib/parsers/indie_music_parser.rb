# frozen_string_literal: true

require 'json'

# IndieMusicJsonParser is a class to parse information from sports api
class IndieMusicJsonParser
  def initialize(text)
    @json_data = JSON.parse(text)
  end

  def to_data
    parse_each_activity
  end

  private

  def parse_each_activity
    @json_data.map do |activity|
      IndieMusicActivityParser.new(activity).parse
    end
  end
end

# IndieMusicActivityParser will parse activity information
class IndieMusicActivityParser
  def initialize(activity)
    @activity = activity
  end

  def parse
    {
      title: title,
      website: website,
      infos: infos
    }
  end

  private

  def title
    @activity['title']
  end

  def website
    @activity['sourceWebPromite']
  end

  def infos
    @activity['showInfo'].map do |info|
      {
        start_time: start_time(info),
        end_time: end_time(info),
        location: location(info),
        location_name: location_name(info)
      }
    end
  end

  def start_time(info)
    info['time']
  end

  def location(info)
    info['location']
  end

  def location_name(info)
    info['locationName']
  end

  def end_time(info)
    info['endTime']
  end
end
