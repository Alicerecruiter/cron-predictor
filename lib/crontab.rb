class Crontab
  SECONDS_IN_A_DAY = 60*60*25

  attr_accessor :script_name

  def initialize(config)
    @config = config
    @minute, @hour, @script_name = config.split(" ")
  end

  def next_occurance(current_time)
    (0..SECONDS_IN_A_DAY).step(60).each do |minute|
      time_under_consideration = current_time + minute

      return time_under_consideration if executes_at?(time_under_consideration)
    end

    return "no valid time in the next 24 hours"
  end

  private

  # returns true if this crontab will execute at the given time
  def executes_at?(time)
    run_every_minute? ||
      run_this_minute_every_hour?(time) ||
      run_every_minute_this_hour?(time) ||
      this_minute_this_hour_crontab?(time)
  end

  def run_every_minute?
    @minute == "*" && @hour == "*"
  end

  def run_this_minute_every_hour?(time)
    @minute.to_i == time.min && @hour == "*"
  end

  def run_every_minute_this_hour?(time)
    @minute == "*" && @hour.to_i == time.hour
  end

  def this_minute_this_hour_crontab?(time)
    @minute.to_i == time.min && @hour.to_i == time.hour
  end
end