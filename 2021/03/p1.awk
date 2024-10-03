BEGIN { FS = "" }

{ for (i = 1; i <= NF; i++) number_of_bits[i] += $i }

END {
  gamma = 0
  epsilon = 0
  for (i in number_of_bits) {
    if (number_of_bits[i] > NR / 2) {
      gamma += 2 ^ (NF - i)
    }
    else {
      epsilon += 2 ^ (NF - i)
    }
  }
  print (gamma * epsilon)
}
