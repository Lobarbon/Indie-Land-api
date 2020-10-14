# frozen_string_literal: true

# Parser is a class to parse information from sports api
class Parser
  def initialize(text)
    @text = text

    # Retrieve what weed need
    @parse_data = {}
  end

  # def parse_baseketball

  # TODO: Parse game information and save into the disk

  def save(path = './spec/fixtures/sports_result.yaml')
    File.write(path, YAML.dump(@data))
  end
end
