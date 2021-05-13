require 'ripper'
require 'xmlsimple'
require 'pry'
require 'pry-byebug'

input_file_path = File.expand_path("../#{ARGV[0]}",__FILE__)
src = File.read input_file_path

case File.extname(ARGV[0])
when '.auk'
  tokenized_src = Ripper.tokenize(src).select{|e| !e.include?(' ') && e != "\n" && e != ',' && e != "\'" && e != "\""}
  #ヒアドキュメントでメトリクス表示
when '.xml'
  doc = XmlSimple.xml_in(src).to_s
  tokenized_src = Ripper.tokenize(doc).select{|e| e =~ /[^\s\[\]\{\}]/ && e != ',' && e != "\""}
end

puts "Token: #{tokenized_src.size}"
