#!/usr/bin/gawk -f

BEGIN {
    FS = "[,= ]"
}

/^[0-9]+/ {
  paper[int($2)][int($1)] = 1
}

/^fold/ {
  for (y in paper) {
    for (x in paper[y]) {
      if ($3 == "x" && int(x) > int($4)) {
        paper[y][x-2*(x-$4)] = 1
        delete paper[y][x]
      } 
      if ($3 == "y" && int(y) > int($4)) {
        paper[y-2*(y-$4)][x] = 1
        delete paper[y][x]
        if (length(paper[y]) == 0)
          delete paper[y]
      }  
    }
  }
  if (!result) {
    for (y in paper) {
      for (x in paper[y]) {
        result++
      }
    }
    print result
  }
}

END {
  for (y in paper) {
    for (x in paper[y]) {
      if (int(x) > maxx) maxx = int(x)
    }
    if (int(y) > maxy) maxy = int(y)
  }
  for (y = 0; y <= maxy; y++) {
    for (x = 0; x <= maxx; x++) {
      printf "%s", paper[y][x] ? "#" : "."
    }
    print ""
  }
}

