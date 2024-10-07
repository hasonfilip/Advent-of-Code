#!/usr/bin/awk -f

BEGIN {
  FS = "(,| -> )"
}

$1 == $3 {
  if ($2 <= $4) {
    for (i = $2; i <= $4; i++) {
      overlap[$1][i]++
    }
  } else {
    for (i = $4; i <= $2; i++) {
      overlap[$1][i]++
    }
  }
  next
}

$2 == $4 {
  if ($1 <= $3) {
    for (i = $1; i <= $3; i++) {
      overlap[i][$2]++
    }
  } else {
    for (i = $3; i <= $1; i++) {
      overlap[i][$2]++
    }
  }
  next
}

{
  if ($1 <= $3 && $2 <= $4) {
    overlap[$1][$2]++
    do {
      $1++
      $2++
      overlap[$1][$2]++
    } while (!($1 == $3 && $2 == $4))
  }
  if ($1 <= $3 && $2 > $4) {
    overlap[$1][$2]++
    do {
      $1++
      $2--
      overlap[$1][$2]++
    } while (!($1 == $3 && $2 == $4))
  }
  if ($1 > $3 && $2 <= $4) {
    overlap[$1][$2]++
    do {
      $1--
      $2++
      overlap[$1][$2]++
    } while (!($1 == $3 && $2 == $4))
  }
  if ($1 > $3 && $2 > $4) {
    overlap[$1][$2]++
    do {
      $1--
      $2--
      overlap[$1][$2]++
    } while (!($1 == $3 && $2 == $4))
  }
  next
}

END {
  for (i in overlap) {
    for (j in overlap[i]) {
      if (overlap[i][j] > 1) {
        result++
      }
    }
  }
  print result
}


