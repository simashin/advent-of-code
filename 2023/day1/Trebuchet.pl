#!/usr/bin/perl

use strict;
use warnings;

open my $fh, '<', $ARGV[0];

my $num_map = {
    one   => 1,
    two   => 2,
    three => 3,
    four  => 4,
    five  => 5,
    six   => 6,
    seven => 7,
    eight => 8,
    nine  => 9,
};

my $res;
while (<$fh>) {
    chomp;
    my $num;
    /(\d|one|two|three|four|five|six|seven|eight|nine)/;
    $num .= $num_map->{$1} || $1;
    /.*(\d|one|two|three|four|five|six|seven|eight|nine)/;
    $num .= $num_map->{$1} || $1;
    $res += $num;
}


print $res;