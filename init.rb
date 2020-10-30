# frozen_string_literal: true

require 'pry'

%w[app]
  .each do |folder|
  require_relative "#{folder}/init"
end
