#!/usr/bin/gawk -f

{
  for (i = 1; i <= NF; i++) {
    stones[i] = int($i)
  }
}

END {
  for (blink = 1; blink <= 25; blink++) {
    for (i in stones) {
      if (!stones[i]) {
        stones[i]++
      } else if (!(length(stones[i]) % 2)) {
        stones[length(stones) + 1] = int(substr(stones[i], length(stones[i]) / 2 + 1))
        stones[i] = int(substr(stones[i], 1, length(stones[i]) / 2))
      } else {
        stones[i] *= 2024
      }
    }
  }
  print length(stones)
}
