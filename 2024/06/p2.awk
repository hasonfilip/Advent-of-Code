#!/usr/bin/gawk -f

BEGIN {
    FS = ""
    x = 1; y = 2
    UP = 1; RIGHT = 2; DOWN = 4; LEFT = 8
}

{
  for (i = 1; i <= NF; i++) {
    if ($i == "#") {
      obstacle [NR, i] = 1
    } else if ($i == "^") {
      start[x] = NR 
      start[y] = i
      direction[x] = -1
      direction[y] = 0
    }
  }
}

END {
  original = 1 
  simulate() 
  original = 0
  for (i = 1; i <= NR; i++) {
    for (j = 1; j <= NF; j++) {
      if (!obstacle[i, j] && is_on_original_path[i][j]) {
        obstacle[i, j] = 1
        simulate()
        delete obstacle[i, j]
      }
    }
  }
  print result
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
  } else if (and(visited[guard[x]][guard[y]], dir())) {
    loop = 1
  } else {
    visited[guard[x]][guard[y]] = or(visited[guard[x]][guard[y]], dir())
    if (original)
      is_on_original_path[guard[x]][guard[y]] = 1
    guard[x] += direction[x]
    guard[y] += direction[y]
  }
}

function dir() {
  if (direction[x] == -1) {
    return UP
  } else if (direction[y] == 1) {
    return RIGHT
  } else if (direction[x] == 1) {
    return DOWN
  } else if (direction[y] == -1) {
    return LEFT
  }
}

function simulate() {
  guard[x] = start[x]
  guard[y] = start[y]
  direction[x] = -1
  direction[y] = 0
  delete visited
  loop = 0
  while (!guard_out_of_map()) {
    move()
    if (loop) {
      result++
      break
    }
  }
}
