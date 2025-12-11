#!/usr/bin/perl 
use 5.036;
use strict; 
use warnings; 
use List::Util qw(sum0);
use Memoize;

my %out = map { my @d = split /:?\s+/; shift(@d) => \@d } <>;

memoize('count_paths');
sub count_paths ($node, $end) {
    return 1 if $node eq $end;
    return sum0 map { count_paths($_, $end) } @{ $out{$node} // [] };
}

say "Part 1: ", count_paths('you', 'out');
say "Part 2: ", count_paths('svr', 'fft') *
                count_paths('fft', 'dac') *
                count_paths('dac', 'out') +
                count_paths('svr', 'dac') *
                count_paths('dac', 'fft') *
                count_paths('fft', 'out');
