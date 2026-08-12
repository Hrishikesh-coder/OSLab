#!/bin/bash
#q4_recursive_count.sh
#Usage: ./q4_recursive_count.sh /path/to/directory
DIR=${1:-.}

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory."
    exit 1
fi

total_files=$(find "$DIR" -type f | wc -l)
echo "Total number of files in '$DIR' and all sub-directories: $total_files"
echo
echo "----- Per-subdirectory file counts -----"
find "$DIR" -type d | while read subdir; do
    count=$(find "$subdir" -maxdepth 1 -type f | wc -l)
    echo "Directory: $subdir -> Files: $count"
done

echo
echo "----- Files created within the past week (recursively) -----"
find "$DIR" -type f -mtime -7 -print