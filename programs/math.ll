func add(l, r) {
  l + r
}

func sub(l, r) {
  l - r
}

func sub_with_wrap(l, r, wrap_to) {
  if (l < r) {
    wrap_to
  } else {
    l - r
  }
}
