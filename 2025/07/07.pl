#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use List::Util qw(first);

my %beams;
my $part1 = 0;
my $part2 = 1;
while (<>) {
	chomp;
	my @chars = split //;
	if (/S/) {
		$beams{first { $chars[$_] eq 'S' } 0..$#chars} = 1;
	} else {
		my %new_beams;
		foreach my $key (keys %beams) {
			if ($chars[$key] eq '^') {
				$part1++;
				$part2 += $beams{$key};
				$new_beams{$key-1} += $beams{$key};
				$new_beams{$key+1} += $beams{$key};

			} else {
				$new_beams{$key} += $beams{$key};
			}
		}
		%beams = %new_beams;
	}
}
say $part1;
say $part2;
