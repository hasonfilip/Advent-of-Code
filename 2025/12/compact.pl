#!/usr/bin/perl
use List::Util 'sum';
my($r,@s); /^\d:$/?push@s,0:/^[.#]+$/?$s[-1]+=tr/#/#/:/^(\d+)x(\d+):\s+(.+)$/&&($r+=$1*$2>=sum map{(split' ',$3)[$_]*$s[$_]}0..$#s)for<>; print$r
