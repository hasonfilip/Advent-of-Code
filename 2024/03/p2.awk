#!/usr/bin/gawk -f 

{
  while(1) {
    if (!dont) {
      if (!match($0, /don't\(\)|mul\([0-9]+,[0-9]+\)/, arr)) break;
      $0 = substr($0, RSTART + RLENGTH)
      if (arr[0] == "don't()") {
        dont = 1
      } else {
        match(arr[0], /([0-9]+),([0-9]+)/, numbers)
        result += numbers[1] * numbers[2]
      }
    } else {
      if(!match($0, /do\(\)/, arr)) break;
      $0 = substr($0, RSTART + RLENGTH)
      if (arr[0] == "do()") {
        dont = 0
      }
    }
  }
}


END {
  print result
}
