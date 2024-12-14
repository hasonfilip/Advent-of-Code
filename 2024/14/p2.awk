#!/usr/bin/gawk -f

BEGIN {
    FS = "[=, ]"
    px = 1; py = 2; vx = 3; vy = 4
    WIDTH = 101; HEIGHT = 103
}

{
  robot[NR][px] = $2; robot[NR][py] = $3
  robot[NR][vx] = $5; robot[NR][vy] = $6
}

END {
  pattern_appearance = 28
  while (1) {
    move()
    ++second
    if (second == pattern_appearance) {
      printf "> "
      if (getline input < "-") {
        if (input == "q") 
          break
        else
          print_positions()
      }
      pattern_appearance += 101
    } 
  }
}

function mod(x, y) {
  return x >= 0 ? x % y : (y + (x % y)) % y
}

function move(    i) {
  for (i in robot) {
    robot[i][px] = mod((robot[i][px] + robot[i][vx]), WIDTH)
    robot[i][py] = mod((robot[i][py] + robot[i][vy]), HEIGHT)
  }
}

function print_positions(    positions, i, row, col) {
  print second
  for (i in robot) {
    positions[robot[i][px], robot[i][py]] = 1
  }
  for (row = 0; row < HEIGHT; row++) {
    for (col = 0; col < WIDTH; col++) {
      printf "%s", (col, row) in positions ? "#" : " "
    }
    printf " %d\n", row
  }
  print "\n\n\n"
  delete positions
}
