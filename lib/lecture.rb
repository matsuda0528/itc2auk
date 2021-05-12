class Lecture
  def initialize( id:, limit:, rooms:, times: )
    @id = id
    @limit = limit
    @rooms = rooms
    @times = times.map{|time| Time.new(days: time['days'], start: time['start'], length: time['length'], weeks: time['weeks'])}
    @periods = @times.map{|time| time.to_period}
  end

  def to_s
    room_text = ""
    @rooms.each do |room|
      room_text += room["id"] + ', '
    end

    period_text = ""
    @periods.flatten.each do |period|
      period_text += period.to_s + ', '
    end
    
    @optimized_period = self.optimized_period

    <<~EOS
    lecture '#{@id}' do
      room #{room_text}
      period #{@optimized_period}
    end
    EOS
  end


  def optimized_period
    tmp = {Mon: 1, Tue: 2, Wed: 3, Thu: 4, Fri: 5}
    period_text = ""
    tmp_arr = []
    last_period = ""
    @periods.flatten.map{|i| i.to_s}.uniq.sort{|a,b| [tmp[a.slice(0..2).to_sym], a.slice(3..-1).to_i] <=> [tmp[b.slice(0..2).to_sym], b.slice(3..-1).to_i]}.each_cons(2) do |current_period, next_period|
      if (current_period.slice(0..2) == next_period.slice(0..2)) && next_period.slice(3..-1).to_i - current_period.slice(3..-1).to_i == 1
        tmp_arr.append [current_period, next_period]
      elsif !tmp_arr.empty?
        period_text += "#{tmp_arr.first.first}: #{tmp_arr.last.last}, "
        tmp_arr = []
      else
        period_text += "#{current_period}, "
      end
      last_period = next_period
    end
    period_text += "#{tmp_arr.first.first}: #{tmp_arr.last.last}" if !tmp_arr.empty?
    period_text += "#{last_period}" if !period_text.include? last_period
    return period_text #ここまでで縦の最適化完了

    tmp_arr = []
    period_text_neo = ""
    last_periods = ""
    period_text.split(',').each_cons(2) do |current_periods, next_periods|
    binding.pry
      curp1, curp2 = current_periods.split(' ').compact
      nexp1, nexp2 = next_periods.split(' ').compact
      if(tmp[nexp1.slice(0..2).to_sym] - tmp[curp1.slice(0..2).to_sym] == 1 && tmp[nexp2.slice(0..2).to_sym] - tmp[curp2.slice(0..2).to_sym] && curp1.slice(3..-1) == nexp1.slice(3..-1) && curp2.slice(3..-1) == nexp2.slice(3..-1))
        tmp_arr.append [curp1, curp2, nexp1, nexp2]
      elsif !tmp_arr.empty?
        period_text_neo += "#{tmp_arr.first.first}: #{tmp_arr.last.last}, "
        tmp_arr = []
      else
        period_text_neo += "#{current_periods},"
      end
      last_periods = next_periods
    end
    period_text_neo += "#{tmp_arr.first.first}: #{tmp_arr.last.last}" if !tmp_arr.empty?
    period_text_neo += "#{last_periods}" if !period_text_neo.include? last_periods
    period_text_neo
  end
end
