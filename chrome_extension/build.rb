require 'fileutils'
require 'json'

current_dir = File.expand_path(File.dirname(__FILE__))

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

js_files = Dir.glob(File.join(current_dir, 'dist', '**', '*.js'))

js_files.each do |file|
  File.open(file, 'r') do |f|
    buffer = f.read()
    config.each do |key, value|
      buffer.gsub!(key, value)
    end
    File.open(file, 'w') do |f|
      f.write(buffer)
    end
  end
end