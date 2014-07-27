File.open('third.gcc') do |file|
  
  my_hash = Hash.new
  
  file.each_with_index do |line, line_index|
    if line.include? ";f_"
      line.each_char do |char| #, char_index|
        puts "Line: #{line}"
        puts "Line Index: #{line_index}"
        puts "Character: #{char}"
        # puts "Character Index: #{char_index}"
      end
      line.slice!(0)
      my_hash[line.strip] = line_index.to_s
      # puts "Line: #{index} - #{line}"
    end
  end
  
  puts "#{my_hash}"
  
end