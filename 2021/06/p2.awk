#!/usr/bin/awk -f

BEGIN { FS = ","}

{
  for (i = 1; i <= NF; i++) {
    fish[i]["timer"] = $i
    fish[i]["count"] = 1
    fish[i]["bd"] = 0
  }

  for (day = 1; day <= 256; day++) {
    for (f in fish) {
      if (fish[f]["timer"] == 0) {
        if (fish[NF]["bd"] == day) {
          fish[NF]["count"] += fish[f]["count"]
        } else {
          fish[++NF]["timer"] = 8
          fish[NF]["count"] = fish[f]["count"]
          fish[NF]["bd"] = day
        }
        fish[f]["timer"] = 7
      }
      fish[f]["timer"]--
    }
  }
}

END {
  for (f in fish) {
    result += fish[f]["count"]
  }
  print result
}
