#!/usr/bin/awk -f

BEGIN {
  FS = "-"
}

{
  caves[$1][$2] = $2 ~ /^[A-Z]+$/
  caves[$2][$1] = $1 ~ /^[A-Z]+$/
}

END {
  for (c in caves) {
    caves[c]["iD"] = c ~ /^[A-Z]+$/ ? 1 : nth_prime(++n)
  }
  
  ways[++possible_ways]["head"] = "start"
  ways[possible_ways]["iD"] = caves["start"]["iD"]

  while (length(ways) > 0) {
    for (way in ways) {
      for (connected in caves[ways[way]["head"]]) {
        if (connected == "iD") {
          continue
        }
        else if (connected == "end") {
          result++
        }
        else if (ways[way]["iD"] % caves[connected]["iD"] != 0 || caves[connected]["iD"] == 1) {
          ways[++possible_ways]["head"] = connected
          ways[possible_ways]["iD"] = ways[way]["iD"] * caves[connected]["iD"]
        }
      }
      delete ways[way]
    }
  }
  print result
}

function nth_prime(n,    count, p, i, is_prime) {
  for (p = 2; count < n; p++) {
    is_prime = 1
    for (i = 2; i * i <= p; i++) {
      if (p % i == 0) {
        is_prime = 0
        break
      }
    }
    if (is_prime) {
      count++
    }
  }
  return p - 1
}
