# frozen_string_literal: true

require 'fileutils'
require 'json'

current_dir = __dir__

source_dir = File.join(current_dir, 'src')
destination_dir = File.join(current_dir, 'dist')

Dir.glob("#{source_dir}/**/*").each do |file|
  if File.directory?(file)
    FileUtils.mkdir_p(file.gsub(source_dir, destination_dir))
  else
    FileUtils.cp(file, file.gsub(source_dir, destination_dir))
  end
end

file = File.join(current_dir, 'config.json')
config = JSON.parse(File.read(file))

Dir.glob(File.join(current_dir, 'dist', '**', '*.js')).each do |target_file|
  File.open(target_file, 'r') do |f|
    buffer = f.read
    config.each { |key, value| buffer.gsub!(key, value) }
    File.write(target_file, buffer)
  end
end
