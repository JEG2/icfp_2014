class Discovermap
  WALL=0
  EMPTY=1
  PILL=2
  POWER_PILL=3
  FRUIT=4
  LAMBDA_MAN_STARTING_POSITION=5
  GHOST_STARTING_POSITION=6

  UP=0
  RIGHT=1
  DOWN=2
  LEFT=3
  @map=[]
  def initialize(val)
    @map=val 
  end
  def hello
    puts "hello"
  end
  def get_cell_contents(x,y) 
    if (@map[x][y] == 0) 
      return "WALL"
    else
    if (@map[x][y] == 1) 
      return "EMPTY"
    else
    if (@map[x][y] == 2) 
      return "PILL"
    else
    if (@map[x][y] == 3) 
      return "POWER_PILL"
    else
    if (@map[x][y] == 4) 
      return "FRUIT"
    else
    if (@map[x][y] == 5) 
      return "EMPTY"
    else
    if (@map[x][y] == 6) 
      return "EMPTY"
    else
      return @map[x][y]
    end
  end
  def get_available_moves(x,y)
    directions= [UP,RIGHT,DOWN,LEFT]
    if (get_cell_contents(x+1,y) == WALL) 
      directions.delete(RIGHT);
   end
   if (get_cell_contents(x,y+1) == WALL) 
     directions.delete(DOWN);
    end
    if (get_cell_contents(x-1,y) == WALL) 
      directions.delete(LEFT);
    end
    if (get_cell_contents(x,y-1) == WALL) 
      directions.delete(UP);
    end
    return directions
  end
end
