#!/usr/bin/perl
use strict;
use warnings;

my $part1 = 0;
my $part2 = 0;

my $line = <>;
chomp $line;

for my $pair (split /,/, $line) {
	my ($start, $end) = split /-/, $pair;
	for my $number ($start .. $end) {
		$part1 += $number if $number =~ /^(.+)\1$/;
		$part2 += $number if $number =~ /^(.+)\1+$/;
	}
}

print "Part 1: $part1\n";
print "Part 2: $part2\n";
