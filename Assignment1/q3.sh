#!/bin/bash
#q3_dircount.sh
#Usage: ./q3_dircount.sh /path/to/directory
DIR=${1:-.}

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory."
    exit 1
fi

file_count=$(find "$DIR" -maxdepth 1 -type f | wc -l)
dir_count=$(find "$DIR" -maxdepth 1 -type d ! -path "$DIR" | wc -l)
total_count=$((file_count + dir_count))

echo "===== Summary for: $DIR ====="
echo "Total files & directories: $total_count"
echo ""
echo "---- Files ----"
find "$DIR" -maxdepth 1 -type f -printf "%f\n"
echo "File count: $file_count"
echo
echo "---- Directories ----"
find "$DIR" -maxdepth 1 -type d ! -path "$DIR" -printf "%f\n"
echo "Directory count: $dir_count"
echo
echo "---- Files created/modified within the past week ----"
recent_files=$(find "$DIR" -maxdepth 1 -type f -mtime -7)
total_size=0

for f in $recent_files; do
    size=$(stat -c%s "$f")
    total_size=$((total_size + size))
    echo "$f ($size bytes)"
done

echo "Total size of files from the past week: $total_size bytes"