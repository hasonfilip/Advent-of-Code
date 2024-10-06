#!/usr/bin/awk -f

/down/ { aim += $2 }
/up/ { aim -= $2 }
/forward/ { H += $2; V += (aim * $2) }
END { print (H*V) }
