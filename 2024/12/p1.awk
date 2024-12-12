#!/usr/bin/gawk -f

BEGIN {
  FS = ""
}

{
  for (i = 1; i <= NF; i++) {
    map[NR][i] = $i
  }
}

END {
  for (i = 1; i <= NR; i++) {
    for (j = 1; j <= NF; j++) {
      if (global_seen[i, j])
        continue
      else {
        region_area = 0
        region_perimeter = 0
        delete seen
        measure_region(i, j)
        # print map[i][j], region_area, region_perimeter
        price += region_area * region_perimeter
      }
    }
  }
  print price
}

function measure_region(x, y,    i, j) {
  global_seen[x, y] = 1
  seen[x, y] = 1 
  region_area++
  for (i = -1; i <= 1; i++) {
    for (j = -1; j <= 1; j++) {
      if (i * j || seen[x + i, y + j])
        continue
      else if (map[x + i][y + j] == map[x][y])
        measure_region(x + i, y + j)
      else
        region_perimeter++
    }
  }
}
