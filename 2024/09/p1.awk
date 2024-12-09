#!/usr/bin/gawk -f 

BEGIN {
  FS = ""
  delete disk
}

{
  for (i = 1; i <= NF; i += 2)
    files[(((i+1)/2)-1)] = $i
  for (i = 2; i <= NF; i += 2)
    free_space[(i/2)-1] = $i

  for (i = 0; i < length(files); i++) {
    for (j = 1; j <= files[i]; j++) {
      append_block(i)
    }
    if (i < length(files) - 1) {
      for (j = 1; j <= free_space[i]; j++) {
        append_block(move_block())
      }
    }
  }
}

END {
  for (i = 0; i < length(disk); i++) {
    checksum += disk[i] * i
  }
  print checksum
}

function append_block(i) {
  disk[length(disk)] = i
}

function move_block(    last) {
  last = length(files) - 1
  files[last]--
  if (files[last] == 0) {
    delete files[last]
  }
  return last
}
