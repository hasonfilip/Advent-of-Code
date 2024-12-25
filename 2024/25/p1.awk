#!/usr/bin/gawk -f

BEGIN {
    FS = ""
}

NF == 0 {
    key = lock = 0
    next
}

!key && !lock {
  if ($0 ~ /#/) {
    lock = 1
    number_of_locks++
  } else if ($0 ~ /./) {
    key = 1\
    number_of_keys++
  }
}

key > 0 {
  for (i = 1; i <= NF; i++)
    if ($i == "#") ++keys[number_of_keys][i]
}

lock > 0 {
  for (i = 1; i <= NF; i++)
    if ($i == "#") ++locks[number_of_locks][i]
}

END {
  for (i = 1; i <= number_of_keys; i++) {
    for (j = 1; j <= number_of_locks; j++) {
      fits = 1
      for (col = 1; col <= NF; col++) {
        if (keys[i][col] + locks[j][col] - 2 > NF) {
          fits = 0
          break
        }
      }
      result += fits
    }
  }
  print result
}
