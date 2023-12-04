#!/usr/bin/perl

use strict;
use warnings;

open my $fh, '<', $ARGV[0];
my @map = <$fh>;
chomp @map;

part1();
part2();

sub part1 {
    my $sum = 0;
    for my $y (0..scalar(@map) - 1) {
        for my $x (0..(length($map[$y])-1)) {
            my $char = substr($map[$y], $x, 1);
            if ($char !~ /\.|\d/ ) {
                my $number = find_number1(\@map, $x, $y);
                $sum += $number if $number;
            }
        }
    }

    print "Part1 : $sum\n";

    sub find_number1 {
        my ($map, $x, $y) = @_;
        my $number = 0;
        Y_LOOP: for my $i (-1, 0, 1) {
            for my $j (-1, 0, 1) {
                next if $j == 0 && $i == 0;
                my $n_row = $y + $i;
                my $n_col = $x + $j;
                next if $n_col < 0 || $n_row < 0 || $n_row > scalar(@$map) || $n_col > length($map->[$n_row]);
                my $num = substr($map->[$n_row], $n_col, 1);
                next unless defined $num;
                my $res_num = 0;
                my $next_col = $n_col + 1;
                if ($num =~ /\d/) {
                    $res_num = $num;
                    my $prev_col = $n_col -1;
                    while (1) {
                        my $prev_num = substr($map->[$n_row], $prev_col, 1);
                        if ($prev_num =~ /\d/) {
                            $res_num = $prev_num . $res_num;
                            --$prev_col;
                        } else {
                            last;
                        }
                    }
                    while (1) {
                        my $next_num = substr($map->[$n_row], $next_col, 1);
                        if ($next_num =~ /\d/) {
                            $res_num = $res_num . $next_num;
                            ++$next_col;
                        } else {
                            last;
                        }
                    }

                }
                $number += $res_num;
                next Y_LOOP if $res_num && $n_col +1 < $next_col;
            }
        }
        return $number;
    }
}


sub part2 {
    my $sum = 0;
    for my $y (0..scalar(@map) - 1) {
        for my $x (0..(length($map[$y])-1)) {
            my $char = substr($map[$y], $x, 1);
            if ($char !~ /\.|\d/ ) {
                my $number = find_number2(\@map, $x, $y);
                $sum += $number if $number;
            }
        }
    }

    print "Part 2: $sum";

    sub find_number2 {
        my ($map, $x, $y) = @_;
        my $number = 0;
        my @numbers_found;
        Y_LOOP: for my $i (-1, 0, 1) {
            for my $j (-1, 0, 1) {
                next if $j == 0 && $i == 0;
                my $n_row = $y + $i;
                my $n_col = $x + $j;
                next if $n_col < 0 || $n_row < 0 || $n_row > scalar(@$map) || $n_col > length($map->[$n_row]);
                my $num = substr($map->[$n_row], $n_col, 1);
                next unless defined $num;
                my $res_num = 0;
                my $next_col = $n_col + 1;
                if ($num =~ /\d/) {
                    $res_num = $num;
                    my $prev_col = $n_col -1;
                    while (1) {
                        my $prev_num = substr($map->[$n_row], $prev_col, 1);
                        if ($prev_num =~ /\d/) {
                            $res_num = $prev_num . $res_num;
                            --$prev_col;
                        } else {
                            last;
                        }
                    }
                    while (1) {
                        my $next_num = substr($map->[$n_row], $next_col, 1);
                        if ($next_num =~ /\d/) {
                            $res_num = $res_num . $next_num;
                            ++$next_col;
                        } else {
                            last;
                        }
                    }

                }
                push @numbers_found, $res_num if $res_num;
                next Y_LOOP if $res_num && $n_col +1 < $next_col;
            }
        }
        $number = $numbers_found[0]*$numbers_found[1] if scalar(@numbers_found) == 2;
        return $number;
    }
}