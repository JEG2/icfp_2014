func car(cons) {
  'cons
}

func cdr(cons) {
  "cons
}

func does_include(list, element) {
  if (#list) {
    0
  } else {
    if (eq('list, element)) {
      1
    } else {
      does_include("list, element)
    }
  }
}