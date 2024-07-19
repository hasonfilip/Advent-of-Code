#!/usr/bin/env python3
import re

MAX_RED, MAX_GREEN, MAX_BLUE = 12, 13, 14

with open ('input/02.txt', 'r') as f:
    part_1_result = 0
    part_2_result = 0
    game_number = 0
    for game in f:
        min_red, min_green, min_blue = 0, 0, 0
        is_possible = True
        game_number += 1
        sets=(re.split(r'[:;]', game)[1:])      
        for set in sets:
            set = set.strip().split(',')
            for cubes in set:
                number, color = cubes.strip().split()
                if color == 'red':
                    if int(number) > MAX_RED:
                        is_possible = False
                    if int(number) > min_red:
                        min_red = int(number)
                elif color == 'green':
                    if int(number) > MAX_GREEN:
                        is_possible = False
                    if int(number) > min_green:
                        min_green = int(number)
                elif color == 'blue':
                    if int(number) > MAX_BLUE:
                        is_possible = False
                    if int(number) > min_blue:
                        min_blue = int(number)

        part_1_result += game_number if is_possible else 0
        part_2_result += (min_red * min_green * min_blue)


print("Answer for part 1 is:", part_1_result)
print("Answer for part 2 is:", part_2_result)
