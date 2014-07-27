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

func map(list, transformer) {
  if (#list) {
    list
  } else {
    {&transformer('list), map("list, transformer)}
  }
}

func map_with_index(list, transformer, index, args) {
  if (#list) {
    list
  } else {
    {&transformer('list, index, args),
     map_with_index("list, transformer, index + 1, args)}
  }
}
