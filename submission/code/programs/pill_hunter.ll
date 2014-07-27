func main(initial_world, ghosts) {
  {0, &step}
}

func step(ai_state, current_world) {
  {0, find_between(0, 3, 3, &has_pill, current_world)}
}

func has_pill(direction, world) {
  or(get_cell(next_to(where_am_i(world), direction), 'world) == PILL,
     get_cell(next_to(where_am_i(world), direction), 'world) == POWER_PILL)
}
