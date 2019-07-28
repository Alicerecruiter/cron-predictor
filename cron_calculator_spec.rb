require 'rspec'
require './cron_calculator'

RSpec.describe CommandlineCronCalculator do
  it "should produce a string representaion in the format '<time of next occurance> <today or tomorrow> - <script name>'" do
    current_time = Time.now
    expected_output = "#{current_time.strftime("%k:%M")} today - ./example_config"

    crontab_calculator = CommandlineCronCalculator.new(current_time, "./example_config")

    expect(STDOUT).to receive(:puts).with(expected_output)

    crontab_calculator.call
  end
end
