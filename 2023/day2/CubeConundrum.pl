#!/usr/bin/perl

use strict;
use warnings;

open my $fh, '<', $ARGV[0];

part1();
part2();

sub part1 {
    my $limits = {
        red   => 12,
        green => 13,
        blue  => 14,
    };
    my $sum_of_ids = 0;

    while (<$fh>) {
        chomp;
        if (/^Game (\d+): (.+)$/) {
            my $game_number = $1;
            my $game_data   = $2;

            my %color_count;
            my $possible = 1;
            while ($game_data =~ /(\d+)\s*(\w+)/g) {
                if ($1 > $limits->{$2}) {
                    $possible = 0;
                    last;
                }
            }
            $sum_of_ids += $game_number if $possible;
        }
    }

    print "Part 1. Sum of IDs of possible games: $sum_of_ids\n";
}

sub part2 {
    my $sum_of_ids = 0;

    seek($fh, 0, 0);
    while (<$fh>) {
        chomp;
        if (/^Game (\d+): (.+)$/) {
            my $game_data   = $2;

            my %color_count;
            while ($game_data =~ /(\d+)\s*(\w+)/g) {
                $color_count{$2} = $1 if $1 > ($color_count{$2} // 0);
            }
            my $multipl = 1;
            $multipl = $multipl * $_ for values %color_count;
            $sum_of_ids += $multipl;
        }
    }

    close $fh;
    print "Part 2. Sum: $sum_of_ids\n";
}