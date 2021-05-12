class Period
  attr_reader :wday
  attr_reader :period
  def initialize( wday:, period: )
    @wday = wday
    @period = period.to_s
  end

  def to_s
    @wday + @period
  end
end
