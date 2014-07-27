#!/usr/bin/env ruby

if ARGV[0]
  file_name = ARGV[0]
else
  puts "Enter File Name: "
  file_name = gets.chomp
end

file_array = [ ]

File.open(file_name) do |file|
  file.each do |line|
    next if line =~ /^\s*$/
    next if line =~ /^\s*;/
    file_array << line
  end
end

# file_array that contains each line

target = ";f_"
my_hash = Hash.new

file_array.each_with_index do |line, line_index|
  if line =~ /;(f_\w+)/
    my_hash[$1] = line_index.to_s
  end
end

File.open("parsed_#{file_name}", 'w') do |logic_file|
  file_array.each do |line|
    line.gsub!(/ f_\w+/) { |match| " "+my_hash[match[1..-1]] }
    logic_file.write(line)
  end
end
