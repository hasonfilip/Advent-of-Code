#!/usr/bin/awk -f

BEGIN {
    RS = ","
}

{
  for (i = 0; i < 2000; ++i) {
    n = ($1 > i) ? ($1 - i) : (i - $1)
    sn = n*(n+1)/2
    steps[i] += sn
  }
}

END {
  min = steps[0]
  for (i = 1; i < 2000; ++i) {
    if (steps[i] < min) {
      min = steps[i]
    }
  }
  print min
}
