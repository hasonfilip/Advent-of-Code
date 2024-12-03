#!/usr/bin/gawk -f 

{
  while(match($0, /do\(\)|don't\(\)|mul\([0-9]+,[0-9]+\)/, arr)) {
    $0 = substr($0, RSTART + RLENGTH)
    if (arr[0] == "do()") {
      dont = 0
    } else if (arr[0] == "don't()") {
      dont = 1
    } else if (!dont){
      match(arr[0], /([0-9]+),([0-9]+)/, numbers)
      result += numbers[1] * numbers[2]
    }
  }
}


END {
  print result
}
