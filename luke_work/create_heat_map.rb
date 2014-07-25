module HeatMap
  class CreateHeatMap
    
    def initialize
      puts "Hello"
      @heat_map = []
    end
    
    attr_reader :heat_map
    
    def create_heat_map(map)
      @heat_map = map.dup
      manage_heat_map
    end
    
    def manage_heat_map
      heat_map.map do |x|
        x.map do |y|
          if y != 0
            y = 1
          else
            y = 0
          end
        end
      end
    end
    
  end
end