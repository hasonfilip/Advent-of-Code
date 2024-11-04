#!/usr/bin/gawk -f


BEGIN {
  FS = ""
  hex["0"] = "0000"
  hex["1"] = "0001"
  hex["2"] = "0010"
  hex["3"] = "0011"
  hex["4"] = "0100"
  hex["5"] = "0101"
  hex["6"] = "0110"
  hex["7"] = "0111"
  hex["8"] = "1000"
  hex["9"] = "1001"
  hex["A"] = "1010"
  hex["B"] = "1011"
  hex["C"] = "1100"
  hex["D"] = "1101"
  hex["E"] = "1110"
  hex["F"] = "1111"
}

{
  for (i = 1; i <= NF; i++) {
    printf "%s", hex[$i]
  }
}

