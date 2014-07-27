func repeat(count, action) {
  if (count > 0) {
    &action()
    repeat(count - 1, action)
  }
}

func reduce_by_count(count, action, initial) {
  if (count > 0) {
    reduce_by_count(count -1, action, &action(initial))
  } else {
    initial
  }
}

func find_between(from, to, default, test, args) {
  if (&test(from, args) > 0) {
    from
  } else {
    if (from < to) {
      find_between(from + 1, to, default, test, args)
    } else {
      default
    }
  }
}
