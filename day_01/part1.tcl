# Advent of Code 2022.  
# Day 01:  Calorie Counter
# Part 1:  What's the most amount of calories carried by an elf?
source ../aoc_library.tcl

# set data [file_to_list demo.txt]
set data [file_to_list_of_lists input.txt]

set sums [list]
foreach elf $data {
    set sum [tcl::mathop::+ {*}$elf]
    lappend sums [tcl::mathop::+ {*}$elf]
}

set max [tcl::mathfunc::max {*}$sums]

puts "The elf carrying the max calories is carrying $max calories"

