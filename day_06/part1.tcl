# Advent of Code 2022.  
# Day 06: Tuning Trouble
# Part 1:  How many characters to process until four consecutive unique characters?
source ../aoc_library.tcl

set data  [file_to_list input.txt]
set pkt   [lindex $data 0]

proc start_of_packet {pkt} {
    set chars [split $pkt ""]

    set i 4
    set num_chars [llength $chars]
    while {$i <= $num_chars} {
        set four_chars [lrange $chars $i-4 $i-1]
        set unique_chars [lsort -u $four_chars]
        puts "$i: $unique_chars"
        if {[llength $unique_chars] == 4} {
            puts "UNIQUE"
            break
        }
        incr i
    }
    return $i

}

set i_start [start_of_packet $pkt]
