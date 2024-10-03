#!/usr/bin/awk -f

NR <= 3 { for (i = 0; i < NR; i++) windows[i] += $1; }

NR > 3 {
  windows[NR % 3] += $1;
  windows[(NR + 1) % 3] += $1;
  if (windows[NR % 3] > windows[(NR + 2) % 3]) {
      result++
  }
  windows[(NR + 2) % 3] = $1;
}

END { print result }
