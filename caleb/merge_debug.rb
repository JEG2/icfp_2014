#!/usr/bin/env ruby
code = []
trace = []
if(ARGV.size != 2)
  puts "expecting two arguments:  the original code, and the trace from the website"
  exit 1
end
code = File.readlines(ARGV[0])
trace = File.readlines(ARGV[1])
trace.each do |line|
  words= line.split(/\s+/)
  code[words[2].to_i]= "-->" +  code[words[2].to_i].chomp() + "	" +  line
end
#puts code
