#!/usr/bin/gawk -f

{
  for (i = 1; i <= NF; i++) {
    stones[i] = int($i)
  }
}

END {
  len = length(stones)
  for (blink = 1; blink <= 75; blink++) {
    for (i in stones) {
      if (length(stones[i]) == 1) {
        digits[blink][stones[i]]++
        delete stones[i]
      } else if (length(stones[i]) % 2 == 0) {
        stones[++len] = int(substr(stones[i], length(stones[i]) / 2 + 1))
        stones[i] = int(substr(stones[i], 1, length(stones[i]) / 2))
      } else {
        stones[i] *= 2024
      }
    }
  }
  result = length(stones)

  for (blink = 0; blink <= 70; blink++) {
    for (digit in digits[blink]) {
      delete stones
      len = 1
      turn = 0
      stones[1] = digit
      while (length(stones)) {
        for (i in stones) {
          if (length(stones[i]) == 1 && turn > 2) {
            digits[blink + turn][stones[i]] += digits[blink][digit]
            delete stones[i]
          } else if (stones[i] == 0) {
            stones[i]++
          } else if (length(stones[i]) % 2 == 0) {
            stones[++len] = int(substr(stones[i], length(stones[i]) / 2 + 1))
            stones[i] = int(substr(stones[i], 1, length(stones[i]) / 2))
          } else {
            stones[i] *= 2024
          }
        }
        turn++
      }
    }
  }

  for (blink = 71; blink <= 75; blink++) {
    for (digit in digits[blink]) {
      delete stones
      stones[1] = digit
      for (b = blink; b <= 75; b++) {
        for (i in stones) {
          if (stones[i] == 0) {
            stones[i]++
          } else if (!(length(stones[i]) % 2)) {
            stones[length(stones) + 1] = int(substr(stones[i], length(stones[i]) / 2 + 1))
            stones[i] = int(substr(stones[i], 1, length(stones[i]) / 2))
          } else {
            stones[i] *= 2024
          }
        }
      }
      result += digits[blink][digit] * length(stones)
    }
  }
  print result
}
