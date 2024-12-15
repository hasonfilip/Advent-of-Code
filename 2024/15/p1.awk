#!/usr/bin/gawk -f 

BEGIN {
    FS = ""
    x = 1; y = 2
    reading_map = 1
}

reading_map {
  for (i = 1; i <= NF; i++) {
    map[NR][i] = "."
    if ($i == "O") {
      boxes[++l][x] = NR
      boxes[l][y] = i
    } else if ($i == "@") {
      robot[x] = NR
      robot[y] = i
    } else if ($i == "#") {
      map[NR][i] = "#"
    }
  }
}

reading_moves {
  for (i = 1; i <= NF; i++) {
    switch ($i) {
      case "^":
        move(-1, 0)
        break
      case "v":
        move(1, 0)
        break
      case "<":
        move(0, -1)
        break
      case ">":
        move(0, 1)
        break
    }
  }
}

NF == 0 {
  reading_map = 0
  reading_moves = 1
}

END {
  print calculate_gps()
}

function map_boxes() {
  delete box_at
  for (box in boxes) {
    box_at[boxes[box][x]][boxes[box][y]] = box
  }
}

function move(dx, dy,    shift, box) {
  map_boxes()
  delete boxes_to_push
  shift[x] = robot[x] + dx
  shift[y] = robot[y] + dy
  while (box_at[shift[x]][shift[y]]) {
    boxes_to_push[length(boxes_to_push) + 1] = box_at[shift[x]][shift[y]]
    shift[x] += dx
    shift[y] += dy
  }
  if (map[shift[x]][shift[y]] == ".") {
    robot[x] += dx
    robot[y] += dy 
    for (box in boxes_to_push) {
      boxes[boxes_to_push[box]][x] += dx
      boxes[boxes_to_push[box]][y] += dy
    }
  }
}

function calculate_gps(    gps) {
  for (box in boxes) {
    gps += 100 * (boxes[box][x] - 1) + (boxes[box][y] - 1)
  }
  return gps
}
