#!/usr/bin/gawk -f 

BEGIN {
  FS = ": "
}

/[xy][0-9]{2}: [01]/ {
  wires[$1] = $2
}

NF == 0 {
  FS = "( AND | OR | XOR | -> )"
}

/ AND / {
  gates[1][++a][1] = $1
  gates[1][a][2] = $2
  gates[1][a][3] = $3
}

/ OR / {
  gates[2][++o][1] = $1
  gates[2][o][2] = $2
  gates[2][o][3] = $3
}

/ XOR / {
  gates[3][++x][1] = $1
  gates[3][x][2] = $2
  gates[3][x][3] = $3
}

END {
  while (1) {
    closed = 0
    for (type in gates) {
      for (gate in gates[type]) {

        if (gates[type][gate][4] == 1) {
          closed++
          continue
        }

        left = gates[type][gate][1] 
        right = gates[type][gate][2]
        out = gates[type][gate][3]

        if (left in wires && right in wires) {
          switch (type) {
            case 1:
              wires[out] = and(wires[left], wires[right])
              break
            case 2:
              wires[out] = or(wires[left], wires[right])
              break
            case 3:
              wires[out] = xor(wires[left], wires[right])
              break
          }

          if (match(out, "z[0-9]{2}"))
            z[int(substr(out, 2))] = wires[out]
          gates[type][gate][4] = 1
          closed++
        }
      }
    }
    if (closed == x + o + a)
      break
  }
  for (i in z)
    decimal += z[i] * 2 ^ i
  print decimal
}
