File.open('third.gcc') do |file|
  target = ";f_"
  my_hash = Hash.new
  
  file.each_with_index do |line, line_index|
    if line =~ /;(f_\w+)/
      my_hash[$1] = line_index.to_s
    end
    # if line.include? target
    #   func_name = line./;f_\w+/
    #   line.each_char do |char| #, char_index|
    #     if char == ";"
    #       char_index = line.index(target)
    #       puts "Line: #{line}"
    #       puts "Line Index: #{line_index}"
    #       puts "Character: #{char}"
    #       puts "Character Index: #{char_index}"
    #     end
    #   end
    #   line.slice!(0)
    #   my_hash[line.strip] = line_index.to_s
    #   # puts "Line: #{index} - #{line}"
    # end
  end
  
  file.rewind
  
  File.open('parsed_ghost_logic.ghc', 'w') do |logic_file|
    file.each do |line|
      line.gsub!(/ f_\w+/) { |match| " "+my_hash[match[1..-1]] }
      logic_file.write(line)
    end
  end
end