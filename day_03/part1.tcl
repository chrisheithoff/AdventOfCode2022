# Advent of Code 2022.  
# Day 03:  Rucksack Reorganization
# Part 1:  Find the items duplicated in each half.
source ../aoc_library.tcl

set data [file_to_list input.txt]
# set data {
# vJrwpWtwJgWrhcsFMMfFFhFp
# jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
# PmmdzqPrVvPwwTWBwg
# wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
# ttgJtRGJQctTZtZT
# CrZsJsPPZsGzwwsLwLmpwMDw
# }

# Convert to ascii and then calculate probability
#   a = 97 - 96  = 1
#   b = 98 - 96  = 2
#    ...
#   z = 122 - 96 = 26
#   A = 65  - 38 = 27
#   B = 66  - 38 = 28
#   ..
#   Z = 90  - 38 = 52
proc get_priority {char} {
    set ascii [scan $char %c]
    if {$ascii >= 97 && $ascii <=122} {
        # Lower case
        set priority [expr {$ascii - 96}]
    } elseif {$ascii >= 65 && $ascii <= 90} {
        #Upper case
        set priority [expr {$ascii - 38}]
    } else {
        error "Not a lower or uppercase letter!"
    }
    return $priority
}

set total 0
foreach sack $data {
    set str_len [string length $sack]
    set size    [expr {$str_len/2}]
    set first   [string range $sack 0 [expr {$size - 1}]]
    set second  [string range $sack $size end]

    set first_dict [dict create]
    foreach item [split $first ""] {
        dict set first_dict $item 1
    }

    foreach item [split $second ""] {
        if {[dict exists $first_dict $item]} {
            incr total [get_priority $item]
            puts "Duplicate:  $item  (Total = $total)"
            break
        }
    }
}
