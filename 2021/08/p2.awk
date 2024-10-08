#!/usr/bin/awk -f

BEGIN {
  RS = "[\n|]"
}

function contains(array, element,    i) {
  for (i in array)
    if (array[i] == element) return 1
  return 0
}

(NR % 2) == 1 {
  five_seg_digits = 0
  six_seg_digits = 0
  for (i = 1; i <= NF; i++) {
    len = split($i, _, "")
    switch (len) {
    case /[2347]/:
      digits[len] = $i
      break
    case 5:
      digits[len][++five_seg_digits] = $i
      break
    case 6:
      digits[len][++six_seg_digits] = $i
      break
    }
  } 
}

# pattern:
#
#  4444
# 5    1
# 5    1
#  6666
# 7    2
# 7    2
#  3333

(NR % 2) == 0 {

  # segments[2]: digit 1
  # segments[3]: digit 7
  # segments[4]: digit 4
  # segments[5]: digits 2 3 5
  # segments[6]: digits 0 6 9
  # segments[7]: digit 8

  for (i = 2; i <= 4; i++) split(digits[i], segments[i], "")
    
  for (s in segments[3]) {
    # segment that is in digit 7 but isn't in digit 1 is segment 4
    if (!contains(segments[2], segments[3][s])) {
      pattern[4] = segments[3][s]
      break
    }
  }


  for (d in digits[6]) {
    split(digits[6][d], segments[6][d], "")
    is_nine = 1
    for (s in segments[4]) {
      if (!contains(segments[6][d], segments[4][s]))
        is_nine = 0
    }
    if (!is_nine) continue
    for (s in segments[6][d]) {
      # segment that isn't in digit 4 but is in digit 9 is either segment 3 or 4
      if (!(contains(segments[4], segments[6][d][s])) && !(segments[6][d][s] == pattern[4])) {
        pattern[3] = segments[6][d][s]
        break
      }
    }
    nine_index = d
  }

  for (d in digits[6]) {
    if (d == nine_index) continue
    is_zero = 1
    for (s in segments[2]) {
      if (!contains(segments[6][d], segments[2][s]))
        is_zero = 0
    }
    if (!is_zero) continue
    for (s in segments[6][d]) {
      # segment that isn't in digit 9 but is in digit 0 is segment 7
      if (!contains(segments[6][nine_index], segments[6][d][s])) {
        pattern[7] = segments[6][d][s]
        break
      }
    }
    for (s in segments[6][nine_index]) {
      # segment that isn't in digit 0 but is in digit 9 is segment 6
      if (!contains(segments[6][d], segments[6][nine_index][s])) {
        pattern[6] = segments[6][nine_index][s]
        break
      }
    }
    for (s in segments[4]) {
      # segment that isn't in digit 1 but is in digit 4 is either segment 5 or 6
      if (!(contains(segments[2], segments[4][s])) && !(segments[4][s] == pattern[6])) {
        pattern[5] = segments[4][s]
        break
      }
    }
    six_index = d
    break
  }

  for (d in digits[6]) {
    if (d == nine_index || d == six_index) continue
    for (s in segments[2]) {
      # segment that is in digit 1 and 6 is segment 2, the other is segment 1
      if (contains(segments[6][d], segments[2][s]))
        pattern[2] = segments[2][s]
      else
        pattern[1] = segments[2][s]
    }
  }

  for (i = 1; i <= NF; i++) {
    len = split($i, out_segments, "")
    switch (len) {
    case 2:
      result += 10 ** (NF - i)
      break
    case 3:
      result += 7 * (10 ** (NF - i))
      break
    case 4:
      result += 4 * (10 ** (NF - i))
      break
    case 7:
      result += 8 * (10 ** (NF - i))
      break
    case /[56]/:
      if (len == 5) {
        if (contains(out_segments, pattern[7])) {
          result += 2 * (10 ** (NF - i))
        }
        else if (contains(out_segments, pattern[5])) {
          result += 5 * (10 ** (NF - i))
        }
        else {
          result += 3 * (10 ** (NF - i))
        }
      }
      if (len == 6) {
        if (!contains(out_segments, pattern[1])) {
          result += 6 * (10 ** (NF - i))
        }
        if (!contains(out_segments, pattern[7])) {
          result += 9 * (10 ** (NF - i))
        }
      }
      break
    }
  }
}

END {
  print result
}
