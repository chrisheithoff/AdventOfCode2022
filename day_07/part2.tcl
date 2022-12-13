# Advent of Code 2022.  
# Day 08: No space left on device  
# Part 1:  Get sum of total size of directories with total size at most 100000
source ../aoc_library.tcl

set data [file_to_list input.txt]
# set data [file_to_list demo.txt]

# If making an object the best thing to do?
catch {Dir destroy}
oo::class create Dir

oo::define Dir {
    variable Name
    variable Files
    variable ChildDirs    
    variable Size

    constructor {name} {
        set Name $name

        # key = file_name   value = size
        set Files [dict create]

        # key = directory name    value = Dir object
        set ChildDirs [dict create]

        # Default -1 indicates that size is unknown
        set Size -1
    }

    method addFile {filename size} {
        puts "Add file $filename, $size"
        dict set Files $filename $size
    }

    method addChildDir {dir_name} {
        puts "Add child dir: $dir_name"
        dict set ChildDirs $dir_name [Dir new $dir_name]
    }

    method getChildDir {dir_name} {
        return [dict get $ChildDirs $dir_name]
    }

    method existsChildDir {dir_name} {
        return [dict exists $ChildDirs $dir_name]
    }

    # methods to return attributes
    method name {}       {return $Name}
    method size {}       {return $Size}
    method files {}      {return $Files}
    method child_dirs {} {return $ChildDirs}

    # Display a tree
    method tree {"indent_level 0"} {
        # First write out the name of the directory
        set indent [string repeat {  } $indent_level]
        puts "$indent|--$Name"

        # Increase the indent_level for the next level of depth
        incr indent_level
        set indent [string repeat {  } $indent_level]

        # Write the list of files
        set file_names [lsort [dict keys $Files]]
        foreach file_name $file_names {
            set file_size [dict get $Files $file_name]
            puts "$indent  $file_name ($file_size)"
        }

        # Recursively call the tree method for the child directories
        set child_dir_names [lsort [dict keys $ChildDirs]]
        foreach child_dir_name $child_dir_names {
            set child_dir [dict get $ChildDirs $child_dir_name]
            $child_dir tree $indent_level
        }
    }

    method compute_sizes {"recursive 0"} {
        if {$recursive == 0} {
            set ::sizes [list]
        }
        set total_size 0

        # Add the file sizes 
        foreach file_size [dict values $Files] {
            incr total_size $file_size
        }

        # Recursively call the tree method for the child directories
        foreach child_dir [dict values $ChildDirs] {
            incr total_size [$child_dir compute_sizes 1]
        }

        set Size $total_size
        lappend ::sizes $Size
        return $Size
    }
}

# Define top level directory and initialize the dir_stack
set root [Dir new ""]

# Make a stack of Dir objects.  
#   "cd a" will add "a" to the stack
#   "cd .." will pop the stack
set dir_stack $root
set current_dir $root

set ls_flag 0
foreach line $data {
    # Change directories with the 'cd' command.
    if {[string match {$ cd *} $line]} {
        set cd_arg [lindex $line 2]
        set ls_flag 0
        if {$cd_arg == "/"} {
            set dir_stack $root
        } elseif {$cd_arg == ".."} {
            lpop dir_stack
        } else {
            lappend dir_stack [$current_dir getChildDir $cd_arg]
        }
        set current_dir [lindex $dir_stack end]

        continue
    }

    # Set a flag for a line with ls.
    if {[string match {$ ls} $line]} {
        set ls_flag 1
        continue
    }

    # Add files or directories after a line with the ls command
    if {$ls_flag == 1} {
        if {[string match {dir *} $line]} {
            set dir_name [lindex $line 1]
            if {![$current_dir existsChildDir $dir_name]} {
                $current_dir addChildDir $dir_name
            }
        } else {
            set filesize [lindex $line 0]
            set filename [lindex $line 1]
            $current_dir addFile $filename $filesize
        }
    }
}

$root tree
$root compute_sizes

set root_size [$root size]
set total_disk_space 70000000
set unused_space [expr {$total_disk_space - $root_size}]
set min_unused_space 30000000
set min_dir_size_to_delete [expr {$min_unused_space - $unused_space}]

set part2_answer 10000000000
foreach dir_size $sizes {
    if {$dir_size >= $min_dir_size_to_delete} {
        if {$dir_size < $part2_answer} {
            puts $dir_size
            set part2_answer $dir_size
        }
    }
}

puts "Part2 answer: $part2_answer"
