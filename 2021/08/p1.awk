#!/usr/bin/awk -f

BEGIN {
  RS = "[\n|]"
}

(NR % 2) == 0 {
  for (i = 1; i <= NF; i++) {
    x = split($i, _, "")
    if (x <= 4 || x == 7) result++
  }
}

END {
  print result
}
