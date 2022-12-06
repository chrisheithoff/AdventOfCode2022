# Advent of Code 2022.  
# Day 06: Tuning Trouble
# Part 2:  Find number of characters to process until 14 consecutive unique chars.

from collections import deque

input_file = 'input.txt'

with open(input_file,'r') as f:
    chars = f.readline()

def chars_until_unique(chars, count):
    de = deque(chars[0:count])
    
    i = count
    for char in chars[count:-1]:
        de.popleft()
        de.append(char)
        i += 1

        print(f'{i}: {de}')

        if len(set(de)) == count:        
            print('UNIQUE')
            break

    return i

num_chars = chars_until_unique(chars,14)
print(num_chars)
