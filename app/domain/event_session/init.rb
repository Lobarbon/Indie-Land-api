# frozen_string_literal: true

%w[lib entities mappers repositories]
  .each do |folder|
    require_relative "#{folder}/init"
  end
