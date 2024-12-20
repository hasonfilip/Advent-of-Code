#!/usr/bin/gawk -f

BEGIN { FS = ", " }

NR == 1 {
  regex = "^("
  for (i = 1; i < NF; i++)
    regex = regex $i "|"
  regex = regex $NF ")+$"
}

NR >= 3 { result += $0 ~ regex }

END { print result }
