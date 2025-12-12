#!/usr/bin/perl 
use strict;
use warnings;
use feature 'say';
use List::Util qw(sum);

my ($result, @sizes) = (0);

while (<>) {
  if (/^\d:$/) {
    push @sizes, 0;
  } elsif (/^[.#]+$/) {
    $sizes[-1] += tr/#/#/;
  } elsif (/^(\d+)x(\d+):\s+(.+)$/) {
    my ($area, @qnt) = ($1 * $2, split ' ', $3);
    $result += $area >= sum map { $qnt[$_] * $sizes[$_] } 0 .. $#qnt;
  }
}

say $result;
