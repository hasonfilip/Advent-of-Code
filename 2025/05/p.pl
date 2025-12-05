#!/usr/bin/env perl
use strict; use warnings; use 5.010;
my (@r, @m, $p1, $p2);
push @r, [$1, $2] while <> =~ /^(\d+)-(\d+)$/;
map { @m && $_->[0] <= $m[-1][1] ? ( $m[-1][1] < $_->[1] && ( $m[-1][1] = $_->[1] ) ) : push @m, $_ } sort { $a->[0] <=> $b->[0] } @r;
$p2 += $_->[1] - $_->[0] + 1 for @m;
do { $p1 += sub { my $n = shift; for (@m) { last if $n < $_->[0]; return 1 if $n <= $_->[1]; } 0 }->($1) if defined && /^(\d+)$/;} while <>;
say "p1: $p1\np2: $p2";
