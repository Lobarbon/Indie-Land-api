# frozen_string_literal: true

folders = %w[view_object]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
