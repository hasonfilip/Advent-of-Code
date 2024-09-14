NR == 1 {
  n = split($1, a, "")
  for (i = 1; i <= n; i++) {
    number_of_bits[i] = 0
  }
}

{
  split($1, a, "")
  for (bit in a) {
    if (a[bit] == 1) {
      number_of_bits[bit]++
    }
  }
}

END {
  gamma = 0
  epsilon = 0
  for (i in number_of_bits) {
    if (number_of_bits[i] > NR / 2) {
      gamma += 2 ^ (n - i)
    }
    else {
      epsilon += 2 ^ (n - i)
    }
  }
  print (gamma * epsilon)
}
