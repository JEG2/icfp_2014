func main(initial_world, undocumented) {
  debug {2 + 3, {42, 0}}
  {13, &step}
}

func step(ai_state, current_world) {
  show(ai_state)
  {0, LEFT}
}

func show(n) {
  debug n
}
