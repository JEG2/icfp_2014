require_relative "../lib/constants.rb"

class Discovermap
  @map=[]
  @lambda_man_info
  @ghost_info=[]
  def initialize(val,val2,val3)
    @map=val 
    @lambda_man_info=val2
    @ghost_info=val3
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
  def get_ghost_locations
    locations = []
    @ghost_info.each { |ghost| 
      locations << ghost[1] 
    }
    return locations
  end
  def get_available_moves(x,y)
    directions= [ ]
    cur_x=x+1
    cur_y=y
    if (get_cell_contents(cur_x,cur_y) != MAP[:wall]) 
      directions << [cur_x,cur_y]
    end
    cur_x=x
    cur_y=y+1
    if (get_cell_contents(cur_x,cur_y) != MAP[:wall]) 
      directions << [cur_x,cur_y]
    end
    cur_x=x-1
    cur_y=y
    if (get_cell_contents(cur_x,cur_y) != MAP[:wall]) 
      directions << [cur_x,cur_y]
    end
    cur_x=x
    cur_y=y-1
    if (get_cell_contents(cur_x,cur_y) != MAP[:wall]) 
      directions << [cur_x,cur_y]
    end
    return directions
  end
end
