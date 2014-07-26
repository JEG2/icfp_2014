module HeatMap
  class CreateHeatMap
    
    def initialize
      puts "Hello"
      @heat_map = []
      @map      = []
    end
    
    attr_reader :heat_map, :map
    
    def create_heat_map(current_map)
      @map = current_map
      @heat_map = current_map.dup
      @heat_map = set_up_heat_map
      @heat_map = apply_map_state
      disperse_heat_of_board_elements
      # Ghosts chilling effect on the map
    end
    
    def set_up_heat_map
      @heat_map.map do |row|
        row.map do |cell|
          if cell != 0
            64      # Set base temp to 64 degrees
          else
            0       # Leave walls as a temp of 0 degrees
          end
        end
      end
    end
    
    def apply_map_state
      @heat_map.map.with_index do |row, x|
        row.map.with_index do |cell, y|
          if cell != 0
            # apply scores of starting map
            mapcell = @map[x][y]
            mapsymbol = MAP.invert[mapcell]
            cell + SCORE[mapsymbol]
            # puts "x index #{x}"
            # puts "y index #{y}"
            # puts "Cell value #{cell}"
            # puts "Score valud #{SCORE[mapsymbol]}"
            # puts "Final Score: #{cell + SCORE[mapsymbol]}"
            cell + SCORE[mapsymbol]
          else
            0
          end
        end
      end
    end
    
    def disperse_heat_of_board_elements
      # each or map with index over a map to get scores
      
      master_adder_array = []
      
      # devide the heat minus 64 (ambiant)
      
      @heat_map.each.with_index do |row, x|
        row.each.with_index do |cell, y|
          if cell != 0 && cell != 64
            stepping_array = [ ]
            stepping_array << [[x,y], 0]
            puts "My stepping_array: #{stepping_array}"
            # puts "I am x: #{x}"
            #puts "I am y: #{y}"
            amb = cell - 64

            set_cell_heat([x,y], amb, stepping_array)
            
            master_adder_array << stepping_array
          end
        end
      end
      apply_elements_heat_to_map(master_adder_array)
    end
      
    def set_cell_heat(cell_address, amb, stepping_array)
      amb = amb/2
      if amb > 0
        
        dirs = Discovermap.new(@map, [[0],[16,11],[0],[3][5]])
        dirs.get_available_moves(cell_address[0],
                                 cell_address[1]).each do |dir|
          if !stepping_array.include?(dir)
            stepping_array << [dir, amb]
            set_cell_heat(dir, amb, stepping_array)
          end
        end
      end
    end
    
    def apply_elements_heat_to_map(master_adder_array)
      puts "master_adder_array: #{master_adder_array}"
    end
  end
end