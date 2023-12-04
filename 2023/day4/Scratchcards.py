import sys
import re

def calc_matches(card):
    match = re.match(r"Card\s+(\d+):(.+)\|(.+)", card)
    if match:
        card_num, winning_numbers, my_numbers = match.groups()
        winning_numbers_set = set(map(int, winning_numbers.split()))
        my_numbers_set = set(map(int, my_numbers.split()))
        matching_numbers = winning_numbers_set.intersection(my_numbers_set)
        return len(matching_numbers)
    return 0

def part1(cards):
    total_points = 0
    for card in cards:
        matches = calc_matches(card)
        if matches:
            total_points += 2 ** (calc_matches(card) - 1)
    print(f"Part 1: {total_points}")

def part2(cards):
    total_cards = 0
    cards_dict = {}
    for card in cards:
        card_match = re.match(r"Card\s+(\d+):", card)
        if card_match:
            card_num = card_match.groups()[0]
            card_num = int(card_num)
            cards_dict[card_num] = cards_dict.get(card_num, 0) + 1
            matches = calc_matches(card)
            for i in range(1, matches + 1):
                cards_dict[card_num + i] = cards_dict.get(card_num + i, 0) + cards_dict[card_num]

    total_sum = sum(cards_dict.values())
    print(f"Part 2: {total_sum}")

def main():
    with open(sys.argv[1], 'r') as file:
        cards = file.read().strip().split('\n')

    part1(cards)
    part2(cards)

if __name__ == "__main__":
    main()
