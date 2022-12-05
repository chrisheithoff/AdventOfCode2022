# Advent of Code 2022.  
# Day 01:  Calorie Counter
# Part 2:  What's the total of the top three elves?
source ../aoc_library.tcl

# set data [file_to_list demo.txt]
set data [file_to_list_of_lists input.txt]

set sums [list]
foreach elf $data {
    set sum [tcl::mathop::+ {*}$elf]
    lappend sums [tcl::mathop::+ {*}$elf]
}

set sorted [lsort -decreasing -integer $sums]

set top_three [tcl::mathop::+ {*}[lrange $sorted 0 2]]

