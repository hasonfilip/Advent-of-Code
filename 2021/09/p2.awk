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
      if (map[x][y] >= 9) continue
      results[++idx] = count(x, y)
    }
  }
  for (r in results) {
    if (results[r] > largest[1]) {
      largest[3] = largest[2]
      largest[2] = largest[1]
      largest[1] = results[r]
    } else if (results[r] > largest[2]) {
      largest[3] = largest[2]
      largest[2] = results[r]
    } else if (results[r] > largest[3]) {
      largest[3] = results[r]
    }
  }
  print largest[1] * largest[2] * largest[3]
}

function count(x, y,    result) {
  if (x < 1 || y < 1 || x > NR || y > NF || map[x][y] >= 9) return 0
  map[x][y] = 10
  result++
  result += count(x - 1, y)
  result += count(x + 1, y)
  result += count(x, y - 1)
  result += count(x, y + 1)
  return result
}
