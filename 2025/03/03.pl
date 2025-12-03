#!/usr/bin/perl
use strict;
use warnings;

my $part1 = 0;
my $part2 = 0;

while (<>) {
	chomp;
	my @batteries = split //;
	my $first = 0;
	my $second = 0;

	for (my $i = 0; $i < @batteries - 1; $i++) {
		if ($batteries[$i] > $first) {
			$first = $batteries[$i];
			$second = 0;
		}
		if ($batteries[$i+1] > $second) {
			$second = $batteries[$i+1];
		}
	}
	$part1 += $first * 10 + $second;
}
print "Part 1: $part1\n";
		
