require_relative './crontab'
require 'time'

class CommandlineCronCalculator
  def initialize(current_time, crontab_file_name)
    @current_time = Time.parse(current_time, Time.now)
    @crontab_file_name = crontab_file_name
    @crontabs = []
  end

  def call
    parse_crontabs
    print_crontab_next_occurances
  end

  private

  def parse_crontabs
    File.open(@crontab_file_name) do |file|
      file.each_line do |line|
        @crontabs << Crontab.new(line)
      end
    end
  end

  def print_crontab_next_occurances
    @crontabs.each do |crontab|
      puts format_crontab_prediction(crontab)
    end
  end

  def format_crontab_prediction(crontab)
    next_occurance = crontab.next_occurance(@current_time)
    "#{next_occurance.strftime("%k:%M")} #{today_or_tomorrow(next_occurance)} - #{crontab.script_name}"
  end

  def today_or_tomorrow(time)
    time.day == Time.now.day ? "today" : "tomorrow"
  end
end
