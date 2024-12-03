#!//usr/bin/gawk -f

{
  while (match($0, /(mul\([0-9]+,[0-9]+\))/)) {
    mul = substr($0, RSTART, RLENGTH)
    match(mul, /([0-9]+),([0-9]+)/, numbers)
    if (mul != last) {
      result += numbers[1] * numbers[2]
      last = mul
    }
    $0 = substr($0, RSTART + RLENGTH)
  }
}

END {
  print result
}
