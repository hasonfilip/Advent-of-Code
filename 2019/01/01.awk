#!/usr/bin/gawk -f 

{
  result_p1 += fuel($1)
  for (f = fuel($1); f > 0; f = fuel(f))
    result_p2 += f
}

END {
  print "Part 1: " result_p1
  print "Part 2: " result_p2
}

function fuel(mass) {
  return int(mass / 3) - 2
}
