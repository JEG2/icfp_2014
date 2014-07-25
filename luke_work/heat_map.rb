require_relative "board_map"
require_relative "create_heat_map"
require_relative "../caleb/Discovermap"

module HeatMap
  class HeatMap
    def initialize
      @given_map = get_map
    end
    
    attr_reader :given_map, :heat_map
    
    def get_map
      map_reader = BoardMap.new
      @given_map = map_reader.readmap
    end
    
    def create_heat_map
      @heat_map = CreateHeatMap.new.create_heat_map
    end
    
    def DM
      dmap = Discovermap.new(get_map)
    end
  end
end