#!/usr/bin/gawk -f

function check_dif(a, b,    seq) {
  seq = ($2 - $1) < 0 ? -1 : 1
  return seq * (b - a) >= 1 && seq * (b - a) <= 3
}

{
  safe = 1
  for (i = 1; i < NF; i++)
    if (!check_dif($i, $(i+1)))
        safe = 0
  if (safe)
    ++result
}

END { print result }
