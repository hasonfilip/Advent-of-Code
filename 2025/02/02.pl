#!/usr/bin/perl
use strict;
use warnings;

sub sum_repeated {
	my ($a, $b) = @_;
	my $sum_range = ($b - $a + 1) * ($a + $b) / 2;
	my $multiplier = 10**length($a) + 1;
	return $multiplier * $sum_range;
}

sub repeated {
	my $number = shift;
	return $number * (10**length($number) + 1);
}

sub part1 {
	my $line = shift;
	my $total = 0;

	for my $pair (split /,/, $line) {
		my ($start, $end) = split /-/, $pair;

		for my $digits (length($start) .. length($end)) {
			next if $digits % 2;

			my $temp_start = (10**($digits-1) > $start) ? 10**($digits-1) : $start;
			my $temp_end = (10**$digits - 1 < $end) ? 10**$digits - 1 : $end;

			my $start_halved = substr($temp_start, 0, $digits / 2);
			++$start_halved if repeated($start_halved) < $temp_start;

			my $end_halved = substr($temp_end, 0, $digits / 2);
			--$end_halved if repeated($end_halved) > $temp_end;

			$total += sum_repeated($start_halved, $end_halved) 
				if $start_halved <= $end_halved;
		}
	}
	return $total;
}

sub part2 {
	# cba
	my $line = shift;
	my $total = 0;

	for my $pair (split /,/, $line) {
		my ($start, $end) = split /-/, $pair;
		for my $number ($start .. $end) {
			$total += $number if $number =~ /^(.+)\1+$/;
		}
	}
	return $total;
}

my $line = <>;
chomp $line;

printf "Part 1: %d\n", part1($line);
printf "Part 2: %d\n", part2($line);
