BEGIN { H = 0; V = 0; aim = 0 }
/^down [0-9]+/ { aim += $2 }
/^up [0-9]+/ { aim -= $2 }
/^forward [0-9]+/ { H += $2; V += (aim * $2) }
END { print (H*V) }