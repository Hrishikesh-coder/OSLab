#!/bin/bash
#q7_word_replace.sh
read -p "Enter file name: " fname
if [ ! -f "$fname" ]; then
    echo "Error: File $fname does not exist."
    exit 1
fi
read -p "Enter the first word (to search for): " word1
read -p "Enter the second word (replacement): " word2

#(i) & (ii): Exact whole-word match check -> replace only exact matches
exact_count=$(grep -ow "$word1" "$fname" | wc -l)
#(iii) Partial match check (substring match, but exclude exact whole-word matches)
partial_count=$(grep -o "$word1" "$fname" | wc -l)
partial_only=$((partial_count - exact_count))
#(iv) Case-insensitive match check
case_insensitive_count=$(grep -oi "$word1" "$fname" | wc -l)

echo "--------------------------------------------------"
if [ "$exact_count" -gt 0 ]; then
    echo "Exact (whole-word) match found: $exact_count occurrence(s)."
    # Replace only whole-word exact matches, case-sensitive
    sed -i "s/\b$word1\b/$word2/g" "$fname"
    echo "Replaced '$word1' with '$word2' (whole-word matches only)."
else
    echo "No exact whole-word match found for '$word1'. No replacement made."
fi

if [ "$partial_only" -gt 0 ]; then
    echo "Note: $partial_only partial match(es) of '$word1' exist as a substring of other words."
    echo "Partial matches were NOT replaced."
else
    echo "No partial (substring-only) matches exist for '$word1'."
fi

if [ "$case_insensitive_count" -gt "$exact_count" ]; then
    echo "Note: '$word1' also matches when case sensitivity is ignored"
    echo "($case_insensitive_count case-insensitive occurrence(s) found vs $exact_count exact-case matches)."
elif [ "$case_insensitive_count" -eq 0 ]; then
    echo "'$word1' does not occur in the file even if case is ignored."
else
    echo "Case-insensitive occurrence count matches exact-case count ($case_insensitive_count)."
fi