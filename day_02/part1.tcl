# Advent of Code 2022.  
# Day 02:  Rock Paper Scissors
# Part 1:  Strategy Guide Total Score
source ../aoc_library.tcl

set data [file_to_list input.txt]

# set data {"A Y" "B X" "C Z"}

# A = Foe rock
# B = Foe paper
# C = Foe scissors
set foe_map {A 1 B 2 C 3}

# X = Me rock
# Y = Me paper
# Z = Me scissors
set my_map  {X 1 Y 2 Z 3}

# key = {foe me}
# value = points 
set result_lookup_table {
    {1 2} 6
    {2 3} 6
    {3 1} 6
    {1 1} 3
    {2 2} 3
    {3 3} 3
    {1 3} 0
    {2 1} 0
    {3 2} 0
 }

set total_score 0

foreach game $data {
    if {[llength $game] != 2} {
        continue
    }

    set foe [dict get $foe_map [lindex $game 0]]
    set me  [dict get $my_map  [lindex $game 1]]

    set result  [dict get $result_lookup_table "$foe $me"]
    set score   [expr {$me + $result}]
    incr total_score $score

    puts "($game) New score = $score.   Total = $total_score"
}

