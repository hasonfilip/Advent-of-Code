#!/usr/bin/perl
use strict;
use warnings;

my $part1 = 0;
my $part2 = 0;
my $position = 50;
my $length = 100;

while (<>) {
	chomp;
	if (/^([A-Za-z])(\d+)$/) {
		if ($1 eq 'R') {
			$position += $2;
		} elsif ($1 eq 'L') {
			$part2-- if $position == 0;
			$position -= $2;
		}

		if ($position >= $length) {
			$part2 += int($position / $length);
		} elsif ($position <= 0) {
			$part2 += (1 + int(-$position / $length));
		}

		$position %= $length;

		$part1++ if $position == 0;
	}
}

print "Part 1: $part1\n";
print "Part 2: $part2\n";
