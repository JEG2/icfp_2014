func repeat(count, action) {
  if (count > 0) {
    &action()
    repeat(count - 1, action)
  }
}

func reduce_by_count(count, transformer, initial) {
  if (count > 0) {
    reduce_by_count(count - 1, transformer, &transformer(initial))
  } else {
    initial
  }
}

func reduce_with_index(list, transformer, index, initial, args) {
  if (#list) {
    initial
  } else {
    debug 42
    debug "list
    debug index + 1
    debug initial
    debug 'list
    debug index
    debug args
    debug 13
    reduce_with_index("list,
                      transformer,
                      index + 1,
                      &transformer(initial, 'list, index, args))
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

func each_with_index(list, action, index, args) {
  if (#list) {

  } else {
    &action('list, index, args)
    each_with_index("list, action, index + 1, args)
  }
}