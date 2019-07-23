#!/usr/bin/env ruby

require './crontab'

config_file_name = ARGV[0]
puts "reading in config file (#{config_file_name})..."

File.open(config_file_name) do |file|
  file.each_line do |line|
    puts Crontab.new(line).to_s
  end
end
