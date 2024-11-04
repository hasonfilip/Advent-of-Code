#!/bin/sh

echo "Part 1: $(gawk -f hex2bin.awk input | gawk -f p1.awk)"
echo "Part 2: $(gawk -f hex2bin.awk input | gawk -f p2.awk)"
