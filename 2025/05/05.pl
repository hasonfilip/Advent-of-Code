#!/usr/bin/env perl
use strict;
use warnings;

sub is_fresh {
	my ($num, @ranges) = @_;
	for (@ranges) { 
		last if $num < $_->[0];
		return 1 if $num <= $_->[1];
	}
	return 0;
}

sub normalize_intervals {
	my @ranges = sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] } @_;
	my @new_ranges;
	for my $r (@ranges) {
		unless (@new_ranges) { push @new_ranges, [@$r]; next }
		my $last = $new_ranges[-1];
		next if $r->[0] >= $last->[0] && $r->[1] <= $last->[1];
		$last->[1] = $r->[1] if $r->[0] <= $last->[1] && $r->[1] > $last->[1];
		push @new_ranges, [@$r] if $r->[0] > $last->[1];
	}
	@new_ranges
}

my @ranges;
my $part1 = 0;
my $part2 = 0;

push @ranges, [$1, $2] while <> =~ /^(\d+)-(\d+)$/;
@ranges = normalize_intervals(@ranges);

$part1 += /^(\d+)$/ ? is_fresh($1, @ranges) : 0 while <>;
$part2 += ($_->[1] - $_->[0] + 1) for @ranges;

print "Part 1: $part1\n";
print "Part 2: $part2\n";
