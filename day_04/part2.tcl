# Advent of Code 2022.  
# Day 04:  Camp Cleanup 
# Part 1:  Find number of assignments that overlap at all.
source ../aoc_library.tcl

set data [file_to_list input.txt]
# set data {
#     2-4,6-8
#     2-3,4-5
#     5-7,7-9
#     2-8,3-7
#     6-6,4-6
#     2-6,4-8
# }
set overlap 0
foreach line $data {

    lassign [split $line ","] elf1 elf2
    lassign [split $elf1 "-"] min1 max1
    lassign [split $elf2 "-"] min2 max2

    if {$max1 >= $min2 && $max1 <= $max2} {
        incr overlap
        puts "$line:   (total = $overlap)"
    } elseif {$max2 >= $min1 && $max2 <= $max1} {
        incr overlap
        puts "$line:   (total = $overlap)"
    }
}

