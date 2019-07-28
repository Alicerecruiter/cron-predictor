#!/usr/bin/env ruby

require_relative './lib/commandline_cron_calculator'

begin
  time = ARGV[0]
  file_name = ARGV[1]

  raise ArgumentError if time.nil? || file_name.nil?

  CommandlineCronCalculator.new(time, file_name).call
rescue ArgumentError => e
  puts "Invalid arguments - #{e.message}, please supply a valid time in the format HH:MM and the path to the file holding the crontabs."
end
