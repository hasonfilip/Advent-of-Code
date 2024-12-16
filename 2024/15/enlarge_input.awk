#!/usr/bin/awk -f

BEGIN {
  FS = ""
}

{
  if ($0 ~ /#/) {
    for (i = 1; i <= NF; i++) {
      switch ($i) {
        case "#":
          printf "##"
          break
        case "O":
          printf "[]"
          break
        case ".":
          printf ".."
          break
        case "@":
          printf "@."
          break
      }
    }
    print ""
  } else {
    print $0
  }
}


