#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(reduce sum);
use builtin qw(trim);

sub sum_up {
  my ($cols, $ops) = @_;
  sum map { reduce { eval "$a $ops->[$_] $b" } @{$cols->[$_]} } 0 .. $#$ops;
}

my (@chars, @cols1, @cols2);
while (<>) {
  last if /[^\d\s]/;
  my $i = 0;
  push @{$cols1[$i++]}, $_ for split;
  push @chars, [split //];
}

my @ops = split;

for (my ($col, $i) = (0, 0); $col <= $#{$chars[0]}; $col++) {
  my $column = trim join '', map { $_->[$col] } @chars;
  $column ? push @{$cols2[$i]}, $column : $i++;
}

printf "Part 1: %d\n", sum_up(\@cols1, \@ops);
printf "Part 2: %d\n", sum_up(\@cols2, \@ops);
