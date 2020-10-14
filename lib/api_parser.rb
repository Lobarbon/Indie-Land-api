# frozen_string_literal: true

require 'json'

# Parser is a class to parse information from sports api
class Parser
  def initialize(text)
    @json_data = JSON.parse(text)

    # Retrieve what weed need
    @target_data = {}
  end

  def parse_baseketball_data
    parse_game_tables
    puts @tables
  end

  def save(path = './spec/fixtures/sports_result.yaml')
    File.write(path, YAML.dump(@data))
  end

  private

  def parse_game_tables
    @tables = @json_data['result']['d']
  end

  # TODO: Parse game information and save into the disk
end
