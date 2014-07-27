#!/usr/bin/ruby
file=File.new(ARGV[0])
print "[ "
file.each_line do |line| 
  myline = line.chomp
  myline = myline.gsub(/ /,'1, ')
  myline = myline.gsub(/#/,'0, ')
  myline = myline.gsub(/\./,'2, ')
  myline = myline.gsub(/o/,'3, ')
  myline = myline.gsub(/%/,'4, ')
  myline = myline.gsub(/\\/,'5, ')
  myline = myline.gsub(/=/,'6, ')
  myline = myline.chop
  myline = myline.chop
  print "[ "
  print myline
  puts " ],"
end
puts "]"
file.close
