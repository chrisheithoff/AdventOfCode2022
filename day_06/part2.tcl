# Advent of Code 2022.  
# Day 06: Tuning Trouble
# Part 2:  Find number of characters to process until 14 consecutive unique chars.
source ../aoc_library.tcl

set data  [file_to_list input.txt]
set str   [lindex $data 0]
# set str "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
# set str "bvwbjplbgvbhsrlpgdmjqwftvncz"
# set str "nppdvjthqldpwncqszvftbrmjlhg"
# set str "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
# set str "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

proc chars_until_unique {str count} {
    set chars [split $str ""]
    set num_chars [llength $chars]

    set i $count
    while {$i <= $num_chars} {
        set consecutive_chars [lrange $chars $i-$count $i-1]
        set unique_chars [lsort -u $consecutive_chars]
        puts "$i: $unique_chars"
        if {[llength $unique_chars] == $count} {
            puts "UNIQUE"
            break
        }
        incr i
    }
    return $i

}

set msg_start [chars_until_unique $str 14]
