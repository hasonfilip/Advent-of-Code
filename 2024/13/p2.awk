#!/usr/bin/gawk -f

BEGIN {
  FS = "[:,+=] ?"
  x 1; y = 2
}

/Button A/{
  A[x] = $3
  A[y] = $5
}

/Button B/{
  B[x] = $3
  B[y] = $5
}

/Prize/{
  prize[x] = $3 + 10000000000000
  prize[y] = $5 + 10000000000000
  j = (A[x] * prize[y] - A[y] * prize[x]) / (A[x] * B[y] - A[y] * B[x])
  i = (prize[x] - j * B[x]) / A[x]
  if (i ~ /^[0-9]+$/ && j ~ /^[0-9]+$/) {
    cost += i * 3 + j
  }
}

END {
  print cost
}
