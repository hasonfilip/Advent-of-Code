#!/usr/bin/gawk -f 

BEGIN {
  for (a = 1024; var != 999999; a++) {
    exec("gawk -v bytes=" a " -f p1.awk input")
  }
  print exec("gawk 'NR == " a - 1 " {print}' input")
}

function exec(cmd) {
  if ((cmd | getline var) > 0) {
    close(cmd)
    return var
  }
  return 0
}
