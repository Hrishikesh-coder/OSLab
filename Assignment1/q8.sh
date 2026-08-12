#!/bin/bash
#birthday_match.sh
#Usage: ./birthday_match.sh 15/05/2000 22/11/1998

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 DD/MM/YYYY DD/MM/YYYY"
    exit 1
fi

get_day() {
    local date_str="$1"
    IFS='/' read dd mm yyyy <<< "$date_str"
    # Validate basic format
    if ! [[ "$dd" =~ ^[0-9]{1,2}$ && "$mm" =~ ^[0-9]{1,2}$ && "$yyyy" =~ ^[0-9]{4}$ ]]; then
        echo "ERROR"
        return
    fi
    date -d "$yyyy-$mm-$dd" +%A 2>/dev/null
}

bday1="$1"
bday2="$2"
day1=$(get_day "$bday1")
day2=$(get_day "$bday2")

if [ -z "$day1" ] || [ "$day1" == "ERROR" ]; then
    echo "Error: Invalid date format for '$bday1'. Use DD/MM/YYYY."
    exit 1
fi

if [ -z "$day2" ] || [ "$day2" == "ERROR" ]; then
    echo "Error: Invalid date format for '$bday2'. Use DD/MM/YYYY."
    exit 1
fi

echo "$bday1 falls on a $day1"
echo "$bday2 falls on a $day2"

if [ "$day1" == "$day2" ]; then
    echo "MATCH: Both people were born on the same day of the week ($day1)."
else
    echo "NO MATCH: They were born on different days of the week."
fi