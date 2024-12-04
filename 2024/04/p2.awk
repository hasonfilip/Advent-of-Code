#!/usr/bin/gawk -f
{
  split($0, map[NR], "")
}

END {
  for (x in map) {
    for (y in map[x]){
      if (map[x][y] == "A" && 
          ((map[x-1][y-1] == "M" && map[x+1][y+1] == "S") ||
           (map[x-1][y-1] == "S" && map[x+1][y+1] == "M")) &&
          ((map[x-1][y+1] == "M" && map[x+1][y-1] == "S") ||
           (map[x-1][y+1] == "S" && map[x+1][y-1] == "M"))) 
      {
        ++result
      }
    }
  }
  print result
}
