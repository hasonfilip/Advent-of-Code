#!/usr/bin/gawk -f

{
  x = $1
  for (i = 1; i <= 2000; i++) {
    x = evolve_number(x)
  }
  result += x
}

END {
  print NR
  print result
}

function evolve_number(x) {
  x = xor(x * 64, x) % 16777216
  x = xor(int(x / 32), x) % 16777216
  x = xor(x * 2048, x) % 16777216 
  return x
} 

