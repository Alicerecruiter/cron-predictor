require 'rspec'
require_relative '../lib/cron_calculator'

RSpec.describe CommandlineCronCalculator do
  it "should produce a string representaion in the format '<time of next occurance> <today or tomorrow> - <script name>'" do
    current_time = Time.now.strftime("%k:%M")
    expected_output = "#{current_time} today - /bin/run_me_every_minute"

    crontab_calculator = CommandlineCronCalculator.new(current_time, "./spec/spec_crontabs")

    expect(STDOUT).to receive(:puts).with(expected_output)

    crontab_calculator.call
  end

  context "for invalid crontab 10:60" do
    it "should handle the exception and display a helpful message" do
      current_time = "10:60"
      expected_output = "Invalid time argument - min out of range, please supply a valid time in the format HH:MM"

      expect(STDOUT).to receive(:puts).with(expected_output)
      crontab_calculator = CommandlineCronCalculator.new(current_time, "./spec/spec_crontabs")
    end
  end
end
