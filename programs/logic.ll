func or(l, r) {
  if (l > 0) {
    l
  } else {
    r
  }
}

func and(l, r) {
  if (l > 0) {
    if (r > 0) {
      r
    } else {
      0
    }
  } else {
    0
  }
}

func if_eq(value, test, action, args) {
  if (value == test) {
    &action(args)
  } else {
    value
  }
}

func eq(l, r) {
  l == r
}

func ne(l, r) {
  if (l == r) {
    0
  } else {
    1
  }
}