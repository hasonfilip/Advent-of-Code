#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(first);

#my @map;
my %beams;
while (<>) {
    chomp;
    my @chars = split //;
    if (/S/) {
      #push @beams, first { $chars[$_] eq 'S' } 0..$#chars;
      my $pos = first { $chars[$_] eq 'S' } 0..$#chars;
      $beams{$pos} = 1;
      print $pos, "\n";
    } else {
      #push @map, \@chars;
    }
}
