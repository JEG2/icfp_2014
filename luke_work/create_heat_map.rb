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
      apply_map_state
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
            puts "x index #{x}"
            puts "y index #{y}"
            puts "Cell value #{cell}"
            puts "Score valud #{SCORE[mapsymbol]}"
            puts "Final Score: #{cell + SCORE[mapsymbol]}"
            cell + SCORE[mapsymbol]
            
            # puts SCORE[mapsymbol]
            # puts @map[x.index][y.index]
            # puts y
            # cell + SCORE[MAP.invert[cell]]
          else
            0
          end
        end
      end
    end
  end
end