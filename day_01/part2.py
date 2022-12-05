#!/usr/intel/pkgs/python3/3.10.8/bin/python3
# Advent of Code 2022.  
# Day 01:  Calorie Counter
# Part 2:  What's the total of the top three elves?

def file_to_list_of_lists(file):
    list_of_lists = []
    with open(file) as f_in:
        l = []
        for line in f_in:
            line = line.strip()
            if line != '':
                l.append(int(line))
            else:
                list_of_lists.append(l)
                l = []
    return list_of_lists

calorie_lists = file_to_list_of_lists('input.txt')

totals = [sum(l) for l in calorie_lists].sort(re

totals.sort(reverse=True)

top_three = sum(totals[0:3])

print(f'Top three total = {top_three}')
