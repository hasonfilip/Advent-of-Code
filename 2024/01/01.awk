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
  print "Part 1:", p1
  print "Part 2:", p2
}
