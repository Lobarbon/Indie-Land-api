# frozen_string_literal: true

require 'json'
require 'fileutils'

SAVE_DIR = './spec/fixtures'
SAVE_FILE = 'sports_result.yaml'

# Parser is a class to parse information from sports api
class SportsDataParser
  def initialize(text)
    @json_data = JSON.parse(text)

    # Retrieve what weed need
    @target_data = {}
  end

  def parse_baseketball_data
    @target_data = parse_game_tables
    self
  end

  def save(path = File.join(SAVE_DIR, SAVE_FILE))
    # Create a directory if it doesn't exist
    FileUtils.mkdir_p(SAVE_DIR) unless File.directory?(SAVE_DIR)

    File.write(path, YAML.dump(@target_data))
  end

  private

  def parse_game_tables
    @tables = @json_data['result']['d']
    parse_each_table
  end

  def parse_each_table
    @tables.map do |table|
      TableParser.new(table).parse
    end
  end

  # TODO: Parse game information and save into the disk
end

# TableParse is a class to parse each table data in sports data
class TableParser
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
    }
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
