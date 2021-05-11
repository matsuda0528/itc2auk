require 'rexml/document'
require 'pry'

input_string = File.read("./#{ARGV[0]}")
# File.expand_path("../#{ARGV[0]}",__FILE__)

REXML::Document.new(input_string)
binding.pry
