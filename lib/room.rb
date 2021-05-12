class Room
  def initialize( id:, capacity:, unavailable: nil, travel: nil )
    @id = id
    @capacity = capacity
    @unavailable = unavailable&.map{|time| Time.new(days: time['days'], start: time['start'], length: time['length'], weeks: time['weeks'])}
    @travel = travel
  end

  def to_s
    <<~"EOS"
    room '#{@id}' do
      #{@unavailable&.reduce{|result, i| result.to_s + "\n" + i.to_s}}
    end
    EOS
  end

  # alias_method :inspect, :to_s
end
