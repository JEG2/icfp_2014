#!/usr/bin/env ruby

if ARGV[0]
  file_name = ARGV[0]
else
  puts "Enter File Name: "
  file_name = gets.chomp
end

File.open(file_name) do |file|
  target = ";f_"
  my_hash = Hash.new
  
  file.each_with_index do |line, line_index|
    if line =~ /;(f_\w+)/
      my_hash[$1] = line_index.to_s
    end
  end
  
  file.rewind
  
  File.open("parsed_#{file_name}", 'w') do |logic_file|
    file.each do |line|
      line.gsub!(/ f_\w+/) { |match| " "+my_hash[match[1..-1]] }
      logic_file.write(line)
    end
  end
end