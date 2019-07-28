#!/usr/bin/env ruby

require_relative './lib/commandline_cron_calculator'

CommandlineCronCalculator.new(ARGV[0], ARGV[1]).call