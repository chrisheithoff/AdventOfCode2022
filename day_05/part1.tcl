# Advent of Code 2022.  
# Day 05:  Supply stacks
# Part 1:  Cratemover 9000
source ../aoc_library.tcl

set data [file_to_list_of_lists input.txt]
# set data [file_to_list_of_lists demo.txt]
set stack_data   [lindex $data 0]
set instructions [lindex $data 1]



proc str_index_to_stack_num {col} {
    # 1 -> 1
    # 5 -> 2
    # 9 -> 3
    # 13 -> 4
    return [expr {($col-1) / 4 + 1}]
}

proc make_stacks {stack_data} {
    # Dict of lists
    set stacks [dict create]

    foreach line $stack_data {
        puts $line
        # Go character by character, remembering the string index number.
        set i 0
        foreach char [split $line ""] {
            puts $i
            if {[regexp {[A-Z]} $char]} {
                set stack_num [str_index_to_stack_num $i]
                # puts "$char: $stack_num"
                dict lappend stacks $stack_num $char
            }
            incr i
        }
    }

    # Reverse each list 
    dict for {stack_num stack} $stacks {
        dict set stacks $stack_num [lreverse $stack]
    }

    return $stacks
}

set stacks [make_stacks $stack_data]

foreach instruction $instructions {
    set times  [lindex $instruction 1]
    set from   [lindex $instruction 3]
    set to     [lindex $instruction 5]

    # Pop the last item of "from" stack and lappend the "to" stack
    foreach x [lrepeat $times x] {
        dict with stacks {
            set popped [lpop $from]
            lappend $to $popped
            puts "Move $popped from $from to $to"
        }
    }
}

set result ""
foreach key [lsort -integer [dict keys $stacks]] {
    append result [lindex [dict get $stacks $key] end]
}

puts "The top box in each stack is: $result"


