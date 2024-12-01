#!/usr/bin/gawk -f 

{
  l[NR] = $1
  r[NR] = $2
}

END {
  asort(l)
  asort(r)
  for (i = 1; i <= NR; i++) {
    occurances[r[i]]++
    p1 += (l[i] > r[i]) ? (l[i] - r[i]) : (r[i] - l[i])
  }
  for (i in l) {
    p2 += l[i] * occurances[l[i]]
  }
  printf "Part 1: %d\nPart 2: %d\n", p1, p2
}
