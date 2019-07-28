require './crontab'

class CommandlineCronCalculator
  def initialize(current_time, config_file_name)
    @current_time = current_time
    @config_file_name = config_file_name
    @crontabs = []
    puts "reading in config file (#{@config_file_name})..."
  end

  def call
    parse_crontabs
    print_crontab_next_occurances
  end

  private

  def parse_crontabs
    File.open(@config_file_name) do |file|
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
    next_occurance = crontab.next_occurance(@current_time).strftime("%k:%M")
    today_or_tomorrow = today_or_tomorrow(next_occurance)
    "#{next_occurance} #{today_or_tomorrow} - #{@config_file_name}"
  end

  def today_or_tomorrow(time)
    "today"
  end
end
