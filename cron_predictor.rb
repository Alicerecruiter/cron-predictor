#!/usr/bin/env ruby

require './cron_calculator'

CommandlineCronCalculator.new(ARGV[0], ARGV[1]).call