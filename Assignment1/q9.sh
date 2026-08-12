#!/bin/bash
#q9_factorial.sh
read -p "Enter a non-negative integer: " n

if ! [[ "$n" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid non-negative integer."
    exit 1
fi

factorial() {
    local num=$1
    local result=1
    for (( i=2; i<=num; i++ )); do
        result=$((result * i))
    done
    echo "$result"
}

start=$(date +%s.%N)
fact=$(factorial "$n")
end=$(date +%s.%N)
elapsed=$(echo "$end - $start" | bc)

echo "Factorial of $n is: $fact"
echo "Time taken: $elapsed seconds"