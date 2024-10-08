#!/usr/bin/awk -f

BEGIN {
  FS = ""
}

{
  for (i = 1; i <= NF; i++) {
    map[NR][i] = $i
  }
}

END {
  for (x = 1; x <= NR; x++) {
    for (y = 1; y <= NF; y++) {
      if (((x - 1 < 1)  || (map[x-1][y] > map[x][y])) &&
          ((y - 1 < 1)  || (map[x][y-1] > map[x][y])) &&
          ((x + 1 > NR) || (map[x+1][y] > map[x][y])) &&
          ((y + 1 > NF) || (map[x][y+1] > map[x][y])))
        result += map[x][y] + 1
    }
  }
  print result
}
