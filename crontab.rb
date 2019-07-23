class Crontab
  def initialize(config)
    @config = config
    @minute, @hour, @script_name = config.split(" ")
  end

  def to_s
    "#{next_occurance} #{today_or_tomorrow} - #{@script_name}"
  end

  def next_occurance
    "asdf"
  end

  def today_or_tomorrow
    "today"
  end
end
