#!/usr/bin/gawk -f 

BEGIN {
  FS = ""
  delete files
  delete free_space
}

{
  offset = 0
  for (i = 1; i <= NF; i++) {
    if (i % 2) {
      files[length(files)]["blocks"] = $i
      files[length(files) - 1]["offset"] = offset
    } else {
      free_space[length(free_space)]["blocks"] = $i 
      free_space[length(free_space) - 1]["offset"] = offset
    }
    offset += $i
  }

  for (i = length(files) - 1; i >= 0; i--) {
    for (j in free_space) {
      if (free_space[j]["offset"] > files[i]["offset"])
        break
      if (free_space[j]["blocks"] >= files[i]["blocks"]) {
        free_space[j]["blocks"] -= files[i]["blocks"]
        files[i]["offset"] = free_space[j]["offset"]
        free_space[j]["offset"] += files[i]["blocks"]
        if (free_space[j]["blocks"] == 0)
          delete free_space[j]
        break
      }
    }
  }
}

END {
  for (file in files) {
    for (offset = files[file]["offset"]; offset < files[file]["offset"] + files[file]["blocks"]; offset++) {
      checksum += offset * file 
    }
  }
  print checksum
}
