#!/usr/bin/gawk -f

function sgn(x) {
  return x < 0 ? -1 : x > 0 ? 1 : 0
}

function check_dif(a, b) {
  return seq * (b - a) >= 1 && seq * (b - a) <= 3
}

{
  safe = 1
  fix = 0
  seq = sgn(sgn($2 - $1) + sgn($3 - $2) + sgn($4 - $3))
  if (!seq)
    next
  for (i = 1; i < NF; i++) {
    if (!check_dif($i, $(i+1))) {
        safe = 0
    }
  }
  if (safe)
    ++result
}

END { print result }
