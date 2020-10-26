# frozen_string_literal: true

require 'json'

module Lobarbon
  module Mapper
    # Data Mapper
    class ActivityMapper
      def initialize(gateway_class = Lobarbon::MusicApi)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find
        to_data
      end

      private

      def to_data
        map_each_activity
      end

      def map_each_activity
        json_data = JSON.parse(@gateway.data)
        json_data.map do |activity|
          DataMapper.new(activity).build_entity
        end
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(activity)
          @activity = activity
        end

        def build_entity
          Lobarbon::Entity::Activity.new(
            title: title,
            website: website,
            infos: infos
          )
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
            InfoMapper.new(info).build_entity
          end
        end
      end

      # InfoMapper will map activity detail information
      class InfoMapper
        def initialize(info)
          @info = info
        end

        def build_entity
          Lobarbon::Entity::ActivityInfo.new(
            start_time: start_time,
            end_time: end_time,
            address: address,
            location: location
          )
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
end
