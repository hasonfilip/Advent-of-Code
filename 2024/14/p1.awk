#!/usr/bin/gawk -f

BEGIN {
    FS = "[=, ]"
    x = 1 
    y = 2
    WIDTH = 101
    HEIGHT = 103
    MIDDLE[x] = (WIDTH - 1) / 2
    MIDDLE[y] = (HEIGHT - 1) / 2
    SECONDS = 100
}

{
  p[x] = $2; p[y] = $3
  v[x] = $5; v[y] = $6
  for (second = 1; second <= SECONDS; second++) {
    p[x] = mod((p[x] + v[x]), WIDTH)
    p[y] = mod((p[y] + v[y]), HEIGHT)
  }
  quadrants[quadrant()]++
}

END {
  print quadrants[1] * quadrants[2] * quadrants[3] * quadrants[4]
}

function mod(x, y) {
  return x >= 0 ? x % y : (y + (x % y)) % y
}

function quadrant() {
  if (p[x] < MIDDLE[x] && p[y] < MIDDLE[y])
    return 1
  if (p[x] < MIDDLE[x] && p[y] > MIDDLE[y])
    return 2
  if (p[x] > MIDDLE[x] && p[y] < MIDDLE[y])
    return 3
  if (p[x] > MIDDLE[x] && p[y] > MIDDLE[y])
    return 4
}
