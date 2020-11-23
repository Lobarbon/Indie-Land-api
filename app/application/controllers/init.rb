# frozen_string_literal: true

Dir.glob("#{__dir__}/*.rb").sort.each do |file|
  require file
end

folders = %w[routes]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
