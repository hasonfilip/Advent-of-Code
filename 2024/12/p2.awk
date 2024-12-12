#!/usr/bin/gawk -f

BEGIN {
  FS = ""
  signs[-1]; signs[1]
  part1 = part1 ? part1 : 0
  part2 = part2 ? part2 : !part1
}

{
  for (i = 1; i <= NF; i++) {
    map[NR][i] = $i
  }
}

END {
  for (i = 1; i <= NR; i++) {
    for (j = 1; j <= NF; j++) {
      if (!global_seen[i, j]) {
        region_area = region_perimeter = 0
        delete seen; delete fence
        fence_region(i, j)
        measure_fence()
        price += region_area * region_perimeter
      }
    }
  }
  print price
}

function fence_region(x, y,    i, j) {
  global_seen[x, y] = seen[x][y] = 1 
  region_area++
  for (i = -1; i <= 1; i++) {
    for (j = -1; j <= 1; j++) {
      if (i * j || seen[x + i][y + j])
        continue
      else if (map[x + i][y + j] == map[x][y])
        fence_region(x + i, y + j)
      else
        fence[x][y][i, j] = 1
    }
  }
}

function measure_fence() {
  for (x in fence) {
    for (y in fence[x]) {
      if (part1)
        region_perimeter += length(fence[x][y])
      if (part2) {
        for (f in fence[x][y]) {
          if (fence[x][y][f]) {
            split(f, direction, SUBSEP)
            for (sign in signs)
              for (i = sign; fence[x + direction[2] * i][y + direction[1] * i][f]; i += sign)
                fence[x + direction[2] * i][y + direction[1] * i][f] = 0
            region_perimeter++
            fence[x][y][f] = 0
          }
        }
      }
    }
  }
}
