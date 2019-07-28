class Crontab
  SECONDS_IN_A_MINUTE = 60
  SECONDS_IN_A_DAY = SECONDS_IN_A_MINUTE*60*25

  attr_accessor :script_name

  def initialize(config)
    @config = config
    @minute, @hour, @script_name = config.split(" ")
  end

  def next_occurance(current_time)
    (0..SECONDS_IN_A_DAY).step(60).each do |minute|
      potential_time = current_time + minute

      return potential_time if will_execute_at?(potential_time)
    end

    return "no valid time in the next 24 hours"
  end

  private

  # returns true if this crontab will execute at the given time
  def will_execute_at?(time)
    @minute == "*" && @hour == "*" ||
      @minute.to_i == time.min && @hour == "*" ||
      @minute == "*" && @hour.to_i == time.hour ||
      @minute.to_i == time.min && @hour.to_i == time.hour
  end
end
