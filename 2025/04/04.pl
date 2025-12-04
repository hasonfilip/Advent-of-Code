#!/usr/bin/perl
use strict;
use warnings;

sub remove_rolls {
    my ($arr_ref, $indices_ref) = @_;
    
    for my $idx (@$indices_ref) {
        my ($i, $j) = @$idx;
        $arr_ref->[$i][$j] = '.';
    }
}

sub find_accessible_rolls {
	my @rolls = @_;
	my @accessible_rolls;
	for my $i (0 .. $#rolls) {
		for my $j (0 .. $#{$rolls[$i]}) {
			next if $rolls[$i][$j] ne '@';
			my $neighbors = 0;
			for my $di (-1, 0, 1) {
				for my $dj (-1, 0, 1) {
					next if $di == 0 && $dj == 0;
					my ($ni, $nj) = ($i + $di, $j + $dj);
					next if $ni < 0 || $ni > $#rolls;
					next if $nj < 0 || $nj > $#{$rolls[$ni]};
					$neighbors ++ if $rolls[$ni][$nj] eq '@';
				}
			}
			push @accessible_rolls, [$i, $j] if $neighbors < 4;
		}
	}
	return @accessible_rolls;
}

my @rolls;

while (<>) {
	chomp;
	my @chars = split //;
	push @rolls, \@chars;
}


my @to_remove = find_accessible_rolls(@rolls);
my $part1 = @to_remove;
my $part2 = 0;

while (scalar @to_remove > 0) {
	$part2 += scalar @to_remove;
	remove_rolls(\@rolls, \@to_remove);
	@to_remove = find_accessible_rolls(@rolls);
}

print "Part 1: $part1\n";
print "Part 2: $part2\n";
