folders = %w[models controllers views]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end