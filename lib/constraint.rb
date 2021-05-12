class Constraint
  def initialize( type:, required: false, lectures: distribution['class'] )
    @type = type
    @required = required
    @lectures = lectures
  end
  
  def to_s
    lecture_text = ""
    @lectures.each do |lec|
      lecture_text += lec["id"] + ', '
    end
    <<~EOS
    #{@type} do
      lecture #{lecture_text}
    end
    EOS
  end
end
