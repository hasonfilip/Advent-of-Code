#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

sub distance {
  my ($a, $b) = @_;
  return sqrt(
    ($b->[0] - $a->[0])**2 +
    ($b->[1] - $a->[1])**2 +
    ($b->[2] - $a->[2])**2
  );
}

my @distances;
my @boxes;
while (<>) {
	chomp;
  my @coords = split /,/;
  for my $i (0 .. $#boxes) {
    my $dist = distance($boxes[$i], \@coords);
    push @distances, { i => $i, j => scalar(@boxes), dist => $dist };
  }
  push @boxes, \@coords;
}
my @shortest = (sort { $a->{dist} <=> $b->{dist} } @distances);
my @sets;
my $i = 1;

for my $connection (@shortest) {
  my $set_i;
  my $set_j;
  
  for my $idx (0 .. $#sets) {
    if (exists $sets[$idx]->{$connection->{i}}) {
      $set_i = $idx;
    }
    if (exists $sets[$idx]->{$connection->{j}}) {
      $set_j = $idx;
    }
  }
  
  if (defined $set_i && defined $set_j) {
    if ($set_i != $set_j) {
      for my $key (keys %{$sets[$set_j]}) {
        $sets[$set_i]->{$key} = 1;
      }
      splice @sets, $set_j, 1;
    }
  } elsif (defined $set_i) {
    $sets[$set_i]->{$connection->{j}} = 1;
  } elsif (defined $set_j) {
    $sets[$set_j]->{$connection->{i}} = 1;
  } else {
    push @sets, { $connection->{i} => 1, $connection->{j} => 1 };
  }
  if ($i == 1000) {
    my @largest = (sort { (keys %$b) <=> (keys %$a) } @sets)[0 .. 2];
    my $product = 1;
    for my $set (@largest) {
      my $size = scalar keys %$set;
      $product *= $size;
    }
    say "Part 1: ", $product;
  }
  if (scalar(@sets) == 1 && scalar(keys %{$sets[0]}) == scalar(@boxes)) {
    say "Part 2: ", $boxes[$connection->{i}]->[0] * $boxes[$connection->{j}]->[0];
    exit 0;
  }
  $i++;
}
