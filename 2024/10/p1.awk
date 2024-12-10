#!/usr/bin/gawk -f 

BEGIN {
    FS = ""
}

{
  for (i = 1; i <= NF; i++) {
    map[NR, i] = $i
  }
}

END {
  for (i = 1; i <= NR; i++) {
    for (j = 1; j <= NF; j++) {
      if (map[i, j] == 0) {
        delete visited
        find_trailhead(i, j)
      }
    }
  }
  print result 
}

function find_trailhead(x, y,    height) {
  if (visited[x, y])
    return
  else
    visited[x, y] = 1
  height = map[x, y]
  if (height == 9) {
    result++
    return
  }
  if (map[x + 1, y] == height + 1)
    find_trailhead(x + 1, y)
  if (map[x - 1, y] == height + 1)
    find_trailhead(x - 1, y)
  if (map[x, y + 1] == height + 1)
    find_trailhead(x, y + 1)
  if (map[x, y - 1] == height + 1)
    find_trailhead(x, y - 1)
}

