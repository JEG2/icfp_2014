module HeatMap
  class BoardMap
    
    def initialize
      @map_file = "map.dat"
      # @map_file = "board.dat"
      @map_data = []
    end
    
    attr_reader :map_file, :map_data

    def readmap
      map = File.open(map_file)
      @map_data = eval(map.read.gsub(/\s+/,""))
      map.close
      @map_data
    end
  end
end