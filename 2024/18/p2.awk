#!/usr/bin/gawk -f 

BEGIN {
  low = 1024 
  high = exec("wc -l < input")
  while (low < high) {
    mid = int((low + high) / 2)
    print mid
    if (exec("gawk -v bytes=" mid " -f p1.awk input") == 999999)
      high = mid
    else
      low = mid + 1
  }
  print exec("gawk 'NR == " low " {print}' input")
}

function exec(cmd) {
  if ((cmd | getline var) > 0) {
    close(cmd)
    return var
  }
  return 0
}
