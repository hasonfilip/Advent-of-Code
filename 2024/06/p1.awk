#!/usr/bin/gawk -f

BEGIN {
    FS = ""
    x = 1
    y = 2
}

{
  for (i = 1; i <= NF; i++) {
    if ($i == "#") {
      obstacle [NR, i] = 1
    } else if ($i == "^") {
      guard[x] = NR 
      guard[y] = i
      direction[x] = -1
      direction[y] = 0
    }
  }
}

END {
  while (!guard_out_of_map()) {
    move()
  }
  print length(visited)
}

function guard_out_of_map() {
  return (guard[x] < 1 || guard[x] > NR || guard[y] < 1 || guard[y] > NF) 
}

function move() {
  if (obstacle[guard[x] + direction[x], guard[y] + direction[y]]) {
    if (direction[x] == -1) {
      direction[x] = 0; direction[y] = 1
    } else if (direction[y] == 1) {
      direction[x] = 1; direction[y] = 0
    } else if (direction[x] == 1) {
      direction[x] = 0; direction[y] = -1
    } else if (direction[y] == -1) {
      direction[x] = -1; direction[y] = 0
    }
  } else {
    visited[guard[x], guard[y]] = 1
    guard[x] += direction[x]
    guard[y] += direction[y]
  }
}
