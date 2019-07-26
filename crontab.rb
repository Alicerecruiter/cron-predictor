class Crontab
  SECONDS_IN_A_MINUTE = 60
  SECONDS_IN_A_DAY = SECONDS_IN_A_MINUTE*60*25

  def initialize(config)
    @config = config
    @minute, @hour, @script_name = config.split(" ")
  end

  def to_s
    no = next_occurance
    "#{no} #{today_or_tomorrow(no)} - #{@script_name}"
  end

  def next_occurance
    (0..SECONDS_IN_A_DAY).step(SECONDS_IN_A_MINUTE).each do |seconds_into_the_future|
      minute = Time.now + seconds_into_the_future
      if will_execute_at?(minute)
        minute
        break 
      end
    end
  end

  # returns true if this crontab will execute on the given time
  def will_execute_at?(time)
    return true if correct_hour_to_execute?(time.hour) && correct_minute_to_execute?(time.min)

    false
  end

  def today_or_tomorrow(time)
    return "today" if time.day == Time.now.day

    "tomorrow"
  end

  def correct_hour_to_execute?(time)
    return true if @hour == '*'

    @hour == time.hour
  end

  def correct_minute_to_execute?(time)
    return true if @minute == '*'

    @minute == time.minute
  end

  def one_day
    SECONDS_IN_A_DAY
  end
end
