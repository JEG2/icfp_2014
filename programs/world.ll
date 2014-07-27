func where_am_i(world) {
  '" '"world
}

func my_direction(world) {
  '"" '"world
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
