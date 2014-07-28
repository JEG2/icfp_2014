func main(initial_world, ghosts) {
  debug build_heat_map(initial_world)
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

func build_heat_map(world) {
  spread_heat(map_with_index('world, &build_heat_row, 0, world))
}

func build_heat_row(row, y, world) {
  map_with_index(row, &build_heat_cell, 0, {y, world})
}

func build_heat_cell(cell, x, y_and_world) {
  if (cell == WALL) {
    0
  } else {
    if (cell == PILL) {
      64 + 8
    } else {
      if (cell == POWER_PILL) {
        64 + 32
      } else {
        if (and(cell == FRUIT, is_fruit_active("y_and_world))) {
          64 + 128
        } else {
          64
        }
      }
    }
  }
}

func spread_heat(heat_map) {
  heat_map
  each_with_index(heat_map, &spread_row_heat, 0, heat_map)
}

func spread_row_heat(row, y, heat_map) {
  each_with_index(row, &spread_cell_heat, 0, {y, heat_map})
}

func spread_cell_heat(cell, x, y_and_heat_map) {
  if (cell > 64) {
    radiate_heat({x, 'y_and_heat_map}, cell - 64, "y_and_heat_map)
  }
}

func radiate_heat(xy, heat, heat_map) {
  radiate_heat_to(next_to(xy, UP),
                  heat,
                  get_cell(next_to(xy, UP), heat_map))
}

func radiate_heat_to(xy, heat, old_cell) {
  if (ne(old_cell, 0)) {
    debug old_cell
    debug heat
    edit_map(next_to(xy, UP), add_with_wrap(old_cell, heat, 255))
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