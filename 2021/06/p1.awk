#!/usr/bin/awk -f

BEGIN { FS = ","}

{
  split($0, fish, ",")
  for (day = 1; day <= 80; day++) {
    for (f in fish) {
      if (fish[f] == 0) {
        fish[++NF] = 8
        fish[f] = 7
      }
      fish[f]--
    }
  }
  print NF
}
