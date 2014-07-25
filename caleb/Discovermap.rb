require_relative "../lib/constants.rb"

class Discovermap
  @map=[]
  def initialize(val)
    @map=val 
  end
  def hello
    puts "hello"
  end
  def get_cell_contents(x,y) 
    return @map[x][y]
  end
  def get_available_moves(x,y)
    directions= [DIRECTIONS[:up],DIRECTIONS[:right],
                 DIRECTIONS[:down],DIRECTIONS[:left]
                ]
    if (get_cell_contents(x+1,y) == MAP[:wall]) 
      directions.delete(DIRECTIONS[:right]);
    end
    if (get_cell_contents(x,y+1) == MAP[:wall]) 
      directions.delete(DIRECTIONS[:left]);
     end
    if (get_cell_contents(x-1,y) == MAP[:wall]) 
      directions.delete(DIRECTIONS[:down]);
    end
    if (get_cell_contents(x,y-1) == MAP[:wall]) 
      directions.delete(DIRECTIONS[:up]);
    end
    return directions
  end
end
