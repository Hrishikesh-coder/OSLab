#!/bin/bash
#q6_word_search.sh
read -p "Enter file name: " fname

if [ ! -f "$fname" ]; then
    echo "Error: File $fname does not exist."
    exit 1
fi

read -p "Enter word/string to search for: " word
#Total occurrences (partial matches included, since grep -o matches substrings by default)
total=$(grep -o "$word" "$fname" | wc -l)

if [ "$total" -eq 0 ]; then
    echo "The word '$word' was not found in '$fname'."
else
    echo "Total occurrences of '$word': $total"
    echo ""
    echo "Line-by-line breakdown:"
    echo "Line# Frequency-in-line Content"
    grep -n "$word" "$fname" | while IFS=: read lineno content; do
        freq=$(grep -o "$word" <<< "$content" | wc -l)
        echo "$lineno $freq $content"
    done
fi