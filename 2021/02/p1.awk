#!/usr/bin/awk -f

/^down [0-9]+/ { V += $2 }
/^up [0-9]+/ { V -= $2 }
/^forward [0-9]+/ { H += $2 }
END { print (H*V) }
