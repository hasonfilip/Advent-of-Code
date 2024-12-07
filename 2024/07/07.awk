#!/usr/bin/gawk -f
BEGIN {
  FS=":? "
}

{
  delete possib
  possib[1] = $2
  for (i=3; i<=NF; i++) {
    for (j in possib) {
      if (part2)
        append(possib[j] $i)
      append(possib[j] * $i)
      possib[j] += $i
    }
  }
  for (i in possib) {
    if (possib[i] == $1) {
      count += $1
      break
    }
  }
}

END {
  print count
}

function append(value) {
  possib[length(possib)+1] = value
}
