func main(initial_world, undocumented) {
  if (0 == 1) {

  } else {
    debug 0
  }
  if (1 == 1) {
    debug 1
  } else {

  }
  if (1 == 1) {
    debug 2
  }
  if (2 > 1) {
    if (3 <= 4) {
      debug 3
    }
  }
  if (#42) {
    debug 4
  }
  if (#initial_world) {

  } else {
    debug 5
  }
  {0, &step}
}

func step(ai_state, current_world) {
  debug ai_state
  {turn(ai_state), LEFT}
}

func turn(old) {
  if (old == 3) {
    0
  } else {
    old + 1
  }
}
