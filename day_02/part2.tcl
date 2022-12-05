# Advent of Code 2022.  
# Day 02:  Rock Paper Scissors
# Part 2:  Strategy Guide Total Score
source ../aoc_library.tcl

set data [file_to_list input.txt]

# set data {"A Y" "B X" "C Z"}

set foe_map {A 1 B 2 C 3}


# X = Need to lose
# Y = Need to draw
# Z = Need to win

set my_losing_value  [dict create 2 1 3 2 1 3]
set my_winning_value [dict create 1 2 2 3 3 1]
    
set total_score 0

foreach game $data {
    if {[llength $game] != 2} {
        continue
    }

    set foe_value [dict get $foe_map [lindex $game 0]]
    set outcome   [lindex $game 1]

    if {$outcome == "X"} {
        set my_points 0
        set my_value [dict get $my_losing_value $foe_value]
    } elseif {$outcome == "Y"} {
        set my_points 3
        set my_value $foe_value
    } elseif {$outcome == "Z"} {
        set my_points 6
        set my_value [dict get $my_winning_value $foe_value]
    }
    
    set score [expr {$my_value + $my_points}]
    incr total_score $score

    puts "New score = $score.   Total = $total_score"
}

