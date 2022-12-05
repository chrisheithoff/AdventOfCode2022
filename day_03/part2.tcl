# Advent of Code 2022.  
# Day 03:  Rucksack Reorganization
# Part 2:  Find the common item in every three lines.
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

proc get_priority {char} {
    set letters {_ a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z} 
    set priority [lsearch $letters $char]
    return $priority
}

set sum 0
set i 0
foreach pack $data {
    incr i

    # Check for common items in every three consecutive bags.
    if {$i == 1} {
        set inventory [dict create]
    }

    # Add item to inventory for each bag (1, 2 or 3)
    foreach item [split $pack ""] {
        dict set inventory $item $i 1
    }

    # At every third bag, find the item present in all three bags.
    if {$i == 3} {
        dict for {item bags} $inventory {
            if {[dict size $bags]==3} {
                incr sum [get_priority $item]
                puts "$item (sum = $sum)"
            }
        }
        set i 0
    }
}

