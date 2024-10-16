#!/usr/bin/awk -f

BEGIN {
    FS = " -> "
}

NF == 1 {
  template = $1
}

NF == 2 {
  rules[$1] = $2
}

END {
  for (step = 1; step <= 10; step++) {
    len = split(template, chars, "")
    template = chars[1]
    for (i = 2; i <= len; i++) {
      pair = chars[i-1] chars[i]
      for (rule in rules) {
        if (pair == rule) {
          template = template rules[rule]
          break
        }
      }
      template = template chars[i]
    }
  }
  split(template, chars, "")
  for (char in chars) {
    count[chars[char]]++
  }
  asort(count)
  print count[length(count)] - count[1]
}
