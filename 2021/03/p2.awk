#!/usr/bin/awk -f

BEGIN { FS = "" }

{ 
	for (i = 1; i <= NF; i++) {
		O_rating[NR][i] = $i
		CO_rating[NR][i] = $i
		}
	}

END {
	O_rating_sz = NR 
	CO_rating_sz = NR

  for (bit = 1; bit <= NF; bit++) {
    O_bits = 0
    CO_bits = 0

    for (record in O_rating) {
      O_bits += O_rating[record][bit]
      }

    for (record in CO_rating) {
      CO_bits += CO_rating[record][bit]
      }

    O_rating_sz_total = O_rating_sz
    for (record in O_rating) {
      if (O_rating[record][bit] == (O_bits < (O_rating_sz_total / 2)) && 
          O_rating_sz > 1) {
        delete O_rating[record]	
        O_rating_sz--
        }
      }

    CO_rating_sz_total = CO_rating_sz
    for (record in CO_rating) {
      if (CO_rating[record][bit] == (CO_bits >= (CO_rating_sz_total / 2)) && 
          CO_rating_sz > 1) {
        delete CO_rating[record]	
        CO_rating_sz--
        }
      }
		}

	for (record in O_rating) {
		for (bit in O_rating[record]) {
			O += O_rating[record][bit] * (2 ^ (NF - bit))
			} 
		}

	for (record in CO_rating) {
		for (bit in CO_rating[record]) {
			CO += CO_rating[record][bit] * (2 ^ (NF - bit))
			} 
		}

  print O * CO

	}

