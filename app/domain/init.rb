# frozen_string_literal: true

folders = %w[event_session feedback]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
