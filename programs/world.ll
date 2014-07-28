func where_am_i(world) {
  '" '"world
}

func my_direction(world) {
  '"" '"world
}

func is_fruit_active(world) {
  fruit_countdown(world) > 0
}

func fruit_countdown(world) {
  """world
}

func left(direction) {
  if (direction == 0) {
    3
  } else {
    if (direction == 1) {
      0
    } else {
      if (direction == 2) {
        1
      } else {
        2
      }
    }
  }
}

func in_danger(world) {
  sum_ghosts(where_am_i(world), world) > 0
}

func sum_ghosts(xy, world) {
  add(is_ghost(next_to(xy, UP), world),
      add(is_ghost(next_to(xy, RIGHT), world),
          add(is_ghost(next_to(xy, DOWN), world),
              is_ghost(next_to(xy, LEFT), world))))
}

func is_ghost(xy, world) {
  reduce('""world, &is_standard_on_cell, 0, xy)
}

func is_standard_on_cell(sum, ghost, xy) {
  sum + and(eq('ghost, 0), and(eq(''"ghost, 'xy), eq("'"ghost, "xy)))
}
