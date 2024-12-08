#!/usr/bin/gawk -f

BEGIN {
  FS = ""
  x = 1; y = 2
  directions[-1]; directions[1]
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
        delta_x = antenna[a][i][x] - antenna[a][j][x]
        delta_y = antenna[a][i][y] - antenna[a][j][y]
        for (direction in directions) {
          antinode_x = antenna[a][i][x]
          antinode_y = antenna[a][i][y]
          while (antinode_x > 0 && antinode_x <= NF && antinode_y > 0 && antinode_y <= NR) {
            antinodes[antinode_x, antinode_y] = 1
            antinode_x += direction * delta_x
            antinode_y += direction * delta_y
          }
        }
      }
    }
  }
  print length(antinodes)
}
