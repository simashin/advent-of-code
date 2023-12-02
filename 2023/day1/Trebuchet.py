import sys
import re

num_map = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9,
}

res = 0

with open(sys.argv[1], 'r') as file:
    for line in file:
        line = line.strip()
        matches = re.findall(r'(\d|one|two|three|four|five|six|seven|eight|nine)', line, flags=re.IGNORECASE)
        
        if matches:
            first_number = num_map.get(matches[0].lower(), matches[0])
            last_number = num_map.get(matches[-1].lower(), matches[-1])
            concatenated_value = str(first_number) + str(last_number)
            
            res += int(concatenated_value) if concatenated_value.isdigit() else concatenated_value

print(f"Sum: {res}")

