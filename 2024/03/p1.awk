#!/usr/bin/gawk -f

{
  while (match($0, /mul\(([0-9]+),([0-9]+)\)/, mul)) {
    $0 = substr($0, RSTART + RLENGTH)
    result += mul[1] * mul[2]
  }
}

END {
  print result
}
