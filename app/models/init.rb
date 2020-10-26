Dir.glob("#{__dir__}/*.rb").each do |file|
  require file
end

folders = %w[parsers]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
