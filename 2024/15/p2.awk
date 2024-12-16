#!/usr/bin/gawk -f 
# usage: ./enlarge_input.awk input | ./p2.awk

BEGIN {
    FS = ""
    x = 1; y = 2
    y1 = 3; y2 = 4
    reading_map = 1
}

reading_map {
  for (i = 1; i <= NF; i++) {
    if ($i == "[") {
      boxes[++l][x] = NR
      boxes[l][y1] = i 
      map[NR][i] = "."
      boxes[l][y2] = ++i
      map[NR][i] = "."
    } else if ($i == "@") {
      robot[x] = NR
      robot[y] = i
      map[NR][i] = "."
    } else {
      map[NR][i] = $i
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
    # visualisation
    #
    # printf "<ENTER> "
    # print ""
    # getline input < "/dev/tty"
    # print ++moves, $i
    # print_map()
    # print ""
  }
}

NF == 0 {
  reading_map = 0
  reading_moves = 1
}

END {
  print calculate_gps()
  # print_map()
}

function map_boxes() {
  delete box_at
  for (box in boxes) {
    box_at[boxes[box][x]][boxes[box][y1]] = box
    box_at[boxes[box][x]][boxes[box][y2]] = box
  }
}

function move(dx, dy,    box) {
  map_boxes()
  delete boxes_to_push
  delete sboxes
  wall = 0
  shift[x] = robot[x] + dx
  shift[y] = robot[y] + dy
  if (map[shift[x]][shift[y]] == "#") {
    return
  } else if (box_at[shift[x]][shift[y]]) {
    sboxes[box_at[shift[x]][shift[y]]] = 1
  }
  while (length(sboxes)) {
    # print length(sboxes)
    push_boxes(dx, dy)
    if (wall)
      return
  }
  robot[x] += dx
  robot[y] += dy 
  # print length(boxes_to_push)
  for (box in boxes_to_push) {
    boxes[box][x] += dx
    boxes[box][y1] += dy
    boxes[box][y2] += dy
  }
}

function calculate_gps(    gps) {
  for (box in boxes) {
    gps += 100 * (boxes[box][x] - 1) + (boxes[box][y1] - 1)
  }
  return gps
}

function push_boxes(dx, dy,    newsboxes, box, new_x, new_y1, new_y2) {
  delete newsboxes
  for (box in sboxes) {
    boxes_to_push[box] = 1
    new_x = boxes[box][x] + dx 
    new_y1 = boxes[box][y1] + dy
    new_y2 = boxes[box][y2] + dy
    # print robot[x], robot[y], new_x, new_y1, new_y2
    # print dx, dy
    if (map[new_x][new_y1] == "#") {
      wall = 1 
      return 0
    }
    else if (box_at[new_x][new_y1] && !sboxes[box_at[new_x][new_y1]]) {
      newsboxes[box_at[new_x][new_y1]] = 1
    }
    
    if (map[new_x][new_y2] == "#") {
      wall = 1 
      return 0
    }
    else if (box_at[new_x][new_y2] && !sboxes[box_at[new_x][new_y2]]) {
      newsboxes[box_at[new_x][new_y2]] = 1
    }
  }
  delete sboxes 
  for (box in newsboxes) {
    sboxes[box] = 1
  }
  # shift[x] += dx
  # shift[y] += dy * 2
  return length(newsboxes)
}

function print_map(    i, j, skip) {
  map_boxes()
  for (i in map) {
    for (j in map[i]) {
      if (skip) {
        skip = 0
        continue
      }
      if (robot[x] == i && robot[y] == j) {
        printf "@"
      } else if (box_at[i][j]) {
        printf "[]"
        skip = 1
      } else {
        printf "%s", map[i][j]
      }
    }
    printf "\n"
  }
}
