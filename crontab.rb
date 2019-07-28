class Crontab
  SECONDS_IN_A_MINUTE = 60
  SECONDS_IN_A_DAY = SECONDS_IN_A_MINUTE*60*25

  attr_accessor :script_name

  def initialize(config)
    @config = config
    @minute, @hour, @script_name = config.split(" ")
  end

  def next_occurance(current_time)
    @next_occurance ||= current_time
  end

  private

  # returns true if this crontab will execute at the given time
  def will_execute_at?(time)
  end
end
