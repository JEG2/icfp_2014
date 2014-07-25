module HeatMap
  class CreateHeatMap
    
    def initialize
      @heat_map        = []
      @map             = []
      @ghost_shit      = [ 
                      [GHOST_VITALITY[:standard],[8,11],DIRECTIONS[:up]],
                      [GHOST_VITALITY[:standard],[10,12],DIRECTIONS[:up]],
                      [GHOST_VITALITY[:standard],[10,11],DIRECTIONS[:up]],
                      [GHOST_VITALITY[:standard],[10,10],DIRECTIONS[:up]] 
                         ]
      @lambda_man_shit = [[0],[16,11],[0],[3][5]]
    end
    
    attr_reader :heat_map, :map, :ghost_shit, :dirs
    
    def create_heat_map(current_map)
      @map      = current_map
      @heat_map = current_map.dup
      @dirs     = Discovermap.new(@map,@lambda_man_shit,@ghost_shit)
      @heat_map = set_up_heat_map
      @heat_map = apply_map_state
      apply_ghost_positions
      disperse_heat_of_board_elements
      print
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
            cell + SCORE[mapsymbol]
          else
            0
          end
        end
      end
    end
    
    def apply_ghost_positions
      # puts "Before: #{@heat_map}"
      
      @dirs.get_ghost_locations.each do |location|
        #puts "Ghost location: #{location}"
        if @heat_map[location[0]][location[1]] - 32 < 1
          @heat_map[location[0]][location[1]] = 1
        else
          @heat_map[location[0]][location[1]] =
               @heat_map[location[0]][location[1]] - 32
        end
      end
      
      # puts "After: #{@heat_map}"
      # @heat_map
    end
    
    def disperse_heat_of_board_elements   
      master_adder_array = []
      
      # devide the heat minus 64 (ambiant)
      
      @heat_map.each.with_index do |row, x|
        row.each.with_index do |cell, y|
          if cell != 0 && cell != 64
            stepping_array = [ ]
            stepping_array << [[x,y], 0]
            amb = cell - 64
            set_cell_heat([x,y], amb, stepping_array)
            master_adder_array << stepping_array
          end
        end
      end
      apply_elements_heat_to_map(master_adder_array)
    end
      
    def set_cell_heat(cell_address, amb, stepping_array)
      if amb == -1
        amb = 0
      end
      amb = amb/2
      if amb != 0
        @dirs.get_available_moves(cell_address[0],
                                  cell_address[1]).each do |dir|
          if !stepping_array.include?(dir)
            stepping_array << [dir, amb]
            set_cell_heat(dir, amb, stepping_array)
          end
        end
      end
    end
    
    def apply_elements_heat_to_map(master_adder_array)
      master_adder_array.each do |cells_heat_effect|
        cells_heat_effect.each do |cell_heat_modifier|
          cell_to_modify = cell_heat_modifier[0]
          x = @heat_map[cell_to_modify[0]][cell_to_modify[1]]+cell_heat_modifier[1]
          if x <= 1
            x = 1
          end
          if x > 255
            x = 255
          end
          @heat_map[cell_to_modify[0]][cell_to_modify[1]] = x
        end        
      end
    end
    
    def print
      @heat_map.each do |line|
        line.each do |element|
          printf(" %3d,", element)
        end
        puts
      end
      0
    end
  end
end