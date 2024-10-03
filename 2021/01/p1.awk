#!/usr/bin/awk -f

NR == 1 { prev = $1; next }
$0 > prev { count++ }
{ prev = $1 }
END { print count }
