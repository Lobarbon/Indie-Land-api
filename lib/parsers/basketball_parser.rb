# frozen_string_literal: true

require 'json'

module Lobarbon
  module Parsers
    # BasketballJsonParser is a class to parse information from sports api
    class BasketballJsonParser
      def initialize(text)
        @json_data = JSON.parse(text)
      end

      def to_data
        tables = parse_game_tables
        parse_each_table(tables)
      end

      private

      def parse_game_tables
        @json_data['result']['d']
      end

      def parse_each_table(tables)
        tables.map do |table|
          BasketballTableParser.new(table).parse
        end
      end
    end

    # BasketballTableParser is a class to parse each table data in basketball data
    class BasketballTableParser
      def initialize(table)
        @table = table

        ## In some list data, the first element would be Chinese data
        @chinese = 0
      end

      def parse
        {
          time: time,
          country: country,
          league: league,
          away_team: away_team,
          host_team: host_team
        }.transform_keys(&:to_s)
      end

      private

      def time
        @table['kdt']
      end

      def country
        @table['cn'][@chinese]
      end

      def league
        @table['ln'][@chinese]
      end

      def away_team
        @table['atn'][@chinese]
      end

      def host_team
        @table['htn'][@chinese]
      end
    end
  end
end
