# Advent of Code 2022.  
# Day 06: Tuning Trouble
# Part 1:  How many characters to process until four consecutive unique characters?

from collections import deque

input_file = 'input.txt'

with open(input_file,'r') as f:
    chars = f.readline()

def chars_until_unique(chars, count):
    de = deque(chars[0:count])
    
    i = count + 1
    while i <= len(chars):
        de.popleft()
        de.append(chars[i])

        print(f'{i}: {de}')

        if len(set(de)) == count:        
            print('UNIQUE')
            break

        i += 1

    return i

num_chars = chars_until_unique(chars,4)
