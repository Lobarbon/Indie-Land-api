# frozen_string_literal: true

folders = %w[event_session]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
