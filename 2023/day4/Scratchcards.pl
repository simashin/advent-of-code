#!/usr/bin/perl
use strict;
use warnings;

my @cards;

sub calc_matches {
    my $card = shift;
    my ($winning_numbers, $my_numbers) = split(' \| ', $card);
    my @winning_numbers = split(' ', $winning_numbers);
    my @my_numbers = split(' ', $my_numbers);
    my %winning_numbers_set = map { $_ => 1 } @winning_numbers;
    my @matching_numbers = grep { $winning_numbers_set{$_} } @my_numbers;

    return scalar @matching_numbers;
}

sub part1 {
    my $total_points = 0;
    for my $card (@cards) {
        my $matches = calc_matches($card);
        $total_points += 2 ** ($matches - 1) if $matches;
    }
    print "Part1: $total_points\n";
}

sub part2 {
    my $total_cards = 0;
    my %cards;
    for my $card (@cards) {
        my ($card_num) = $card =~ m/Card\s+(\d+):/;
        $cards{$card_num}++;
        my $matches = calc_matches($card);
        for (1..$matches) {
            $cards{$card_num+$_} += 1 * $cards{$card_num};
        }
    }
    my $sum = 0;
    $sum += $_ for values %cards;
    print "Part2: $sum\n";
}

open my $fh, '<', $ARGV[0];
@cards = <$fh>;
chomp @cards;

part1();
part2();