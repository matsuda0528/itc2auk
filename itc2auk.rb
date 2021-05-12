# require 'rexml/document'
# require 'active_support'
# require 'active_support/core_ext'
require 'xmlsimple'
require 'pry'
require 'pry-byebug'
require_relative './lib/lecture.rb'
require_relative './lib/period.rb'
require_relative './lib/room.rb'
require_relative './lib/time.rb'
require_relative './lib/constraint.rb'

# REXML
# input_string = File.read("./#{ARGV[0]}")
# doc = REXML::Document.new(input_string)

# Actice Support
# doc = Hash.from_xml(open "./#{ARGV[0]}")

#XML Simple
doc = XmlSimple.xml_in(open "./#{ARGV[0]}")

rooms = []
doc['rooms'][0]['room'].each do |room|
  rooms.append Room.new( id: room['id'], capacity: room['capacity'], unavailable: room['unavailable'], travel: room['travel'] )
end

lectures = []
doc['courses'].each do |courses|
  courses["course"].each do |course|
    course["config"].each do |config|
      config["subpart"].each do |subpart|
        subpart["class"].each do |lecture|
          lectures.append Lecture.new( id: lecture['id'], limit: lecture['limit'], rooms: lecture['room'], times: lecture['time'] )
        end
      end
    end
  end
end

constraints = []
doc['distributions'].each do |distributions|
  distributions['distribution'].each do |distribution|
    constraints.append Constraint.new( type: distribution['type'], required: distribution['required'], lectures: distribution['class'] )
  end
end

# output_file_dir = File.expand_path("../auk/",__FILE__)
output_file_name = File.basename(ARGV[0]).sub('xml','auk')
File.open("auk/#{output_file_name}", "w"){|f|
  f.puts(rooms + lectures + constraints)
}


