class Time
  def initialize(days:, start:, length:, weeks:)
    @days = days
    @start = start
    @length = length
    @weeks = weeks
  end

  def start_time
    "YYYY/MM/DD HH:MM:SS"
  end

  def end_time
    "YYYY/MM/DD HH:MM:SS"
  end

  def to_s
    "unavailable start_time: #{start_time}, end_time: #{end_time}"
  end

  alias_method :inspect, :to_s

  def to_period
    period = (@start.to_i - 90) / 12 + 1

    wday = []
    wday.append 'Mon' if @days.to_i(2) & 0b1000000 != 0
    wday.append 'Tue' if @days.to_i(2) & 0b0100000 != 0
    wday.append 'Wed' if @days.to_i(2) & 0b0010000 != 0
    wday.append 'Thu' if @days.to_i(2) & 0b0001000 != 0
    wday.append 'Fri' if @days.to_i(2) & 0b0000100 != 0

    wday.map{|w| Period.new(wday: w, period: period)}
  end
end
