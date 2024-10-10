#!/usr/bin/awk -f

BEGIN {
  FS = ""
}

{
  for (i = 1; i <= NF; i++)
    octopus[NR][i] = $i
}

END {
  for (step = 1; !done; step++) {
    flashes = 0
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
    if (flashes == NF * NR)
      break
  }
  print step
}

function flash(x, y,    i, j) {
  octopus[x][y]++
  if (octopus[x][y] != 10) return
  for (i = -1; i <= 1; i++) {
    for (j = -1; j <= 1; j++) {
      if ((i == 0 && j == 0) || x + i < 1 || x + i > NR || y + j < 1 || y + j > NF)
        continue
      flash(x+i, y+j)
    }
  }
}
