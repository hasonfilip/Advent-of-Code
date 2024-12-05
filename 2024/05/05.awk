#!/usr/bin/gawk -f

BEGIN {
  FS = "|";
}

/^[0-9]+\|[0-9]+$/ {
  prev_pages[$2][length(prev_pages[$2])] = $1;
}

NF == 0 {
  FS = ",";
}

/^([0-9]+,)+[0-9]+$/ {
  correct = 1
  for (i = 1; i < NF; i++) {
    for (j = i + 1; j <= NF; j++) {
      for (k in prev_pages[$i]) {
        if (prev_pages[$i][k] == $j) {
          correct = 0;
          x = $i; $i = $j; $j = x;
          break;
        }
      }
    }
  }
  if (correct)
    part1 += $((NF+1)/2);
  else
    part2 += $((NF+1)/2);
}

END {
  print "Part 1: " part1;
  print "Part 2: " part2;
}
