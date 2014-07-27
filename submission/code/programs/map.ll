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