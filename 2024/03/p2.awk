#!/usr/bin/gawk -f 

{
  while(match($0, /do\(\)|don't\(\)|mul\(([0-9]+),([0-9]+)\)/, arr)) {
    $0 = substr($0, RSTART + RLENGTH)
    if (arr[0] == "do()")
      dont = 0
    else if (arr[0] == "don't()")
      dont = 1
    else if (!dont)
      result += arr[1] * arr[2]
  }
}

END {
  print result
}
