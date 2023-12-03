import re
import sys

def part1(lines):
    limits = {
        'red': 12,
        'green': 13,
        'blue': 14,
    }
    sum_of_ids = 0

    for line in lines:
        match = re.match(r'^Game (\d+): (.+)$', line)
        if match:
            game_number, game_data = match.groups()
            
            color_count = {}
            possible = True

            for match in re.finditer(r'(\d+)\s*(\w+)', game_data):
                if int(match.group(1)) > limits.get(match.group(2), 0):
                    possible = False
                    break
            
            if possible:
                sum_of_ids += int(game_number)

    print(f"Part 1. Sum of IDs of possible games: {sum_of_ids}")

def part2(lines):
    sum_of_ids = 0

    for line in lines:
        match = re.match(r'^Game \d+: (.+)$', line)
        if match:
            game_data = match.group(1)

            color_count = {}
            for match in re.finditer(r'(\d+)\s*(\w+)', game_data):
                color_count[match.group(2)] = max(int(match.group(1)), color_count.get(match.group(2), 0))

            multipl = 1
            for value in color_count.values():
                multipl *= value

            sum_of_ids += multipl

    print(f"Part 2. Sum: {sum_of_ids}")

if __name__ == "__main__":
    with open(sys.argv[1], 'r') as file:
        lines = file.readlines()
        part1(lines)
        part2(lines)
