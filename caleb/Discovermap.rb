require_relative "../lib/constants.rb"

class Discovermap
  @map=[]
  @lambda_man_info
  def initialize(val,val2)
    @map=val 
    @lambda_man_info=val2
  end
  def hello
    puts "hello"
  end
  def get_cell_contents(x,y) 
    return @map[x][y]
  end
  def get_lambdaman_position
    return @lambda_man_info[1]
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
