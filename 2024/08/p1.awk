#!/usr/bin/gawk -f

BEGIN {
  FS = ""
  x = 1; y = 2
}

{
  for (i = 1; i <= NF; i++) {
    if ($i != ".") {
      antenna[$i][length(antenna[$i]) + 1][x] = i
      antenna[$i][length(antenna[$i])][y] = NR
    }
  }
}

END {
  for (a in antenna) {
    for (i = 1; i < length(antenna[a]); i++) {
      for (j = i + 1; j <= length(antenna[a]); j++) {
        create_antinode(\
          2 * antenna[a][i][x] - antenna[a][j][x], 
          2 * antenna[a][i][y] - antenna[a][j][y]\
        )
        create_antinode(\
          2 * antenna[a][j][x] - antenna[a][i][x], 
          2 * antenna[a][j][y] - antenna[a][i][y]\
        )
      }
    }
  }
  print length(antinodes) 
}

function create_antinode(x, y) {
  if (x < 1 || x > NF || y < 1 || y > NR)
    return
  antinodes[x, y] = 1
}
