require 'rspec'
require './crontab'

RSpec.describe Crontab do
  it "should produce a string representaion in the format '<time of next occurance> <today or tomorrow> - <script name>'" do
    current_time = Time.now
    current_minute = current_time - current_time.sec
    expected_output = "#{current_minute} today - ./example_script.rb"

    crontab = Crontab.new("* * ./example_script.rb")

    expect(crontab.to_s).to eq expected_output
  end
end
