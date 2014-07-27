func get_cell(xy, map) {
  car(reduce_by_count('xy, &cdr, car(reduce_by_count("xy, &cdr, map))))
}

func next_to(xy, direction) {
  if (direction == 0) {
    {'xy, sub("xy, 1)}
  } else {
    if (direction == 1) {
      {add('xy, 1), "xy}
    } else {
      if (direction == 2) {
        {'xy, add("xy, 1)}
      } else {
        {sub('xy, 1), "xy}
      }
    }
  }
}

func is_junction(xy, map) {
  ne(sum_walls(xy, map), 2)
}

func is_dead_end(xy, map) {
  sum_walls(xy, map) == 3
}

func sum_walls(xy, map) {
  add(is_wall(next_to(xy, UP), map),
      add(is_wall(next_to(xy, RIGHT), map),
          add(is_wall(next_to(xy, DOWN), map),
              is_wall(next_to(xy, LEFT), map))))
}

func is_wall(xy, map) {
  get_cell(xy, map) == WALL
}

func only_move(xy, map) {
  find_between(0, 3, 3, &find_only_move, {xy, map})
}

func find_only_move(direction, xy_and_map) {
  ne(get_cell(next_to('xy_and_map, direction), "xy_and_map), WALL)
}

func edit_map(map, xy, new_cell) {
  map_with_index(map, &edit_row, 0, {xy, new_cell})
}

func edit_row(row, y, xy_and_new_cell) {
  map_with_index(row, &edit_cell, 0, {y, xy_and_new_cell})
}

func edit_cell(cell, x, y_and_xy_and_new_cell) {
  if (and(eq(x, ''"y_and_xy_and_new_cell),
          eq('y_and_xy_and_new_cell, "'"y_and_xy_and_new_cell))) {
    ""y_and_xy_and_new_cell
  } else {
    cell
  }
}
