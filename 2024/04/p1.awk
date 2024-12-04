#!/usr/bin/gawk -f
{
  split($0, map[NR], "")
}

END {
  needle[1] = "X"; needle[2] = "M"; needle[3] = "A"; needle[4] = "S";
  for (x in map) {
    for (y in map[x]){
      for (i = -1; i <= 1; i++) {
        for (j = -1; j <= 1; j++) {
          xmas = 1
          needle_index = 0
          xv = yv = 0
          while (!(++needle_index > length(needle))) {
            if (map[x+(i*(xv++))][y+(j*(yv++))] != needle[needle_index]) {
              xmas = 0
              break
            }
          }
          if (xmas)
            result++
        }
      }
    }
  }
  print result
}
