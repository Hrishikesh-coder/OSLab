#!/bin/bash
#q5_keyword_freq.sh
# Usage: ./q5_keyword_freq.sh File1.java File2.java File3.java File4.java

if [ "$#" -ne 4 ]; then
    echo "Error: Please provide exactly 4 Java file names."
    exit 1
fi

keywords=("public" "class" "int")

printf "%-20s %-10s %-10s %-10s\n" "Filename" "public" "class" "int"
printf "%-20s %-10s %-10s %-10s\n" "--------" "------" "-----" "---"

for file in "$@"; do
    if [ ! -f "$file" ]; then
        printf "%-20s %-10s\n" "$file" "NOT FOUND"
        continue
    fi
    counts=()
    for word in "${keywords[@]}"; do
        c=$(grep -ow "$word" "$file" | wc -l)
        counts+=("$c")
    done
    printf "%-20s %-10s %-10s %-10s\n" "$file" "${counts[0]}" "${counts[1]}" "${counts[2]}"
done