#!/usr/bin/gawk -f

BEGIN {
  LEFT = 0; RIGHT = 1; OPERATOR = 2
}

/z/ {
  z[int(substr($5, 2))][LEFT] = $1 
  z[int(substr($5, 2))][OPERATOR] = $2
  z[int(substr($5, 2))][RIGHT] = $3
  next
}

NF > 3 {
  x[$5][LEFT] = $1
  x[$5][OPERATOR] = $2
  x[$5][RIGHT] = $3
}

END {
  for (i = 1; i < length(z) - 1; i++) {
    zleft = z[i][LEFT]; zoperator = z[i][OPERATOR]; zright = z[i][RIGHT]
    if (zoperator == "XOR") {
      regex = "[xy]0?" i "XOR[xy]0?" i
      if (x[zleft][LEFT] x[zleft][OPERATOR] x[zleft][RIGHT] ~ regex)
        continue
      if (x[zright][LEFT] x[zright][OPERATOR] x[zright][RIGHT] ~ regex)
        continue
    }
    printf "%s%02d -> %s %s %s\n", "z", i, zleft, zoperator, zright
  }
}
