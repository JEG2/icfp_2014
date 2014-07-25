func main(initial_world, ghosts) {
  {build_wandering_map(initial_world), &step}
}

func build_wandering_map(world) {
  map_with_index('world, &build_wandering_row, 0, 'world)
}

func build_wandering_row(row, y, map) {
  map_with_index(row, &build_wandering_cell, 0, {y, map})
}

func build_wandering_cell(cell, x, y_and_map) {
  if (cell == WALL) {
    WALL
  } else {
    4
  }
}

func step(ai_state, current_world) {
  eat_pill_or_wander(ai_state, current_world, find_pill(current_world))
}

func eat_pill_or_wander(ai_state, current_world, pill_direction) {
  if (pill_direction == 4) {
    wander(ai_state, current_world)
  } else {
    {ai_state, pill_direction}
  }
}

func find_pill(current_world) {
  find_between(0, 3, 4, &has_pill, current_world)
}

func has_pill(direction, world) {
  or(get_cell(next_to(where_am_i(world), direction), 'world) == PILL,
     get_cell(next_to(where_am_i(world), direction), 'world) == POWER_PILL)
}

func wander(wandering_map, world) {
  wander_and_update_map(where_am_i(world), wandering_map, world)
}

func wander_and_update_map(xy, wandering_map, world) {
  if (or(is_junction(xy, 'world),
         is_wall(next_to(xy, my_direction(world)), 'world))) {
    update_map(xy,
               wandering_map,
               sub_with_wrap(get_cell(where_am_i(world), wandering_map), 1, 3))
  } else {
    {wandering_map, my_direction(world)}
  }
}

func update_map(xy, wandering_map, move) {
  {edit_map(wandering_map, xy, move), move}
}