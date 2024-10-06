#!/usr/bin/awk -f

/down/ { V += $2 }
/up/ { V -= $2 }
/forward/ { H += $2 }
END { print (H*V) }
