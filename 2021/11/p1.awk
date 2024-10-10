#!/usr/bin/awk -f

BEGIN {
  FS = ""
}

{
  for (i = 1; i <= NF; i++)
    octopus[NR][i] = $i
}

END {
  for (step = 1; step <= 100; step++) {
    for (row in octopus) {
      for (col in octopus[row]){
        flash(row, col)
      }
    }
    for (row in octopus) {
      for (col in octopus[row]){
        if (octopus[row][col] > 9) {
          flashes++
          octopus[row][col] = 0
        }
      }
    }
  }
  print flashes
}

function flash(x, y,    i, j) {
  if (octopus[x][y]++ != 9) return
  for (i = -1; i <= 1; i++) {
    for (j = -1; j <= 1; j++) {
      if ((i == 0 && j == 0) || x + i < 1 || x + i > NR || y + j < 1 || y + j > NF)
        continue
      flash(x+i, y+j)
    }
  }
}

function print_octopuses() {
  for (row in octopus) {
    for (col in octopus[row]) {
      printf "%d", octopus[row][col]
    }
    print ""
  }
}
