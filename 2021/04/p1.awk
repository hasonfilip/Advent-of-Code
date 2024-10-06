#!/usr/bin/awk -f

BEGIN {
    FS = ","
    RS = "\n\n"
  }

# HACK: marked numbers are made negative, 
# thus the numbers are saved with +1, to deal with zero,
# for results, these numbers must be made -1
  
NR == 1 {
  for (i = 1; i <= NF; i++) drawn_numbers[i] = $i + 1
  FS = " "
}

NR > 1 {
  for (i = 1; i <= NF; i++) {
    bingo[NR-1][int((i-1)/5)+1][(i-1)%5+1] = $i + 1
    }
  }

END {
  for (number in drawn_numbers) {
    for (b in bingo) {
      for (r = 1; r <= 5; r++) {
        in_row = 0
        in_column = 0
        for (c = 1; c <= 5; c++) {
          if (bingo[b][r][c] == drawn_numbers[number]) {
            bingo[b][r][c] = -drawn_numbers[number]
            }
          if (bingo[b][r][c] < 0) {
            in_row++
            }
          if (bingo[b][c][r] == drawn_numbers[number]) {
            bingo[b][c][r] = -drawn_numbers[number]
            }
          if (bingo[b][c][r] < 0) {
            in_column++
            }
          }
        if (in_row == 5 || in_column == 5) {
          won = 1
          } 
        }

      if (won) {
        for (rw = 1; rw <= 5; rw++) {
          for (cw = 1; cw <= 5; cw++) {
            if (bingo[b][rw][cw] > 0) {
              unmarked += (bingo[b][rw][cw] - 1)
              } 
            }
          }
        break
        }
      }

    if (won) {
      print (unmarked * (drawn_numbers[number] - 1))
      break
      }
    }
  }
