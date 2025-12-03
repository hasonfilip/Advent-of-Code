#!/usr/bin/perl
use strict;
use warnings;

my @lines = <>;
chomp @lines;

sub solve {
	my $result = 0;
	my $number_of_batteries = shift;
	foreach my $line (@lines) {
		my @batteries = split //, $line;
		my @joltage = (0) x $number_of_batteries;
		for (my $b = 0; $b < @batteries; $b++) {
			my $start = $number_of_batteries - (@batteries - $b);
			$start = 0 if $start < 0;
			for (my $i = $start; $i < $number_of_batteries; $i++) {
				if ($batteries[$b] > $joltage[$i]) {
					$joltage[$i] = $batteries[$b];
					$joltage[$_] = 0 for $i+1 .. $number_of_batteries-1;
					last;
				}
			}
		}
		$result += join('', @joltage);
	}
	return $result;
}

print "Part 1: ", solve(2), "\n";
print "Part 2: ", solve(12), "\n";
