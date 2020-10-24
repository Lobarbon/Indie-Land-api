# frozen_string_literal: true

require 'json'

module Lobarbon
  module Parsers
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
        }.transform_keys(&:to_s)
      end

      private

      def title
        @activity['title']
      end

      def website
        @activity['sourceWebPromote']
      end

      def infos
        @activity['showInfo'].map do |info|
          ParseInfo.new(info).parse_info
        end
      end
    end

    # ParseInfo will parse activity detail information
    class ParseInfo
      def initialize(info)
        @info = info
      end

      def parse_info
        {
          start_time: start_time,
          end_time: end_time,
          address: address,
          location: location
        }.transform_keys(&:to_s)
      end

      def start_time
        @info['time']
      end

      def address
        @info['location']
      end

      def location
        @info['locationName']
      end

      def end_time
        @info['endTime']
      end
    end
  end
end
