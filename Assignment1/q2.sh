#!/bin/bash
#q2_typed_ops.sh
is_integer() {
    [[ "$1" =~ ^-?[0-9]+$ ]]
}
is_real() {
    [[ "$1" =~ ^-?[0-9]+\.[0-9]+$ ]]
}
is_number() {
    is_integer "$1" || is_real "$1"
}
reverse_string() {
    echo "$1" | rev
}
while true; do
    read -p "Enter userv1: " userv1
    read -p "Enter userv2: " userv2
    echo "userv1 = '$userv1', userv2 = '$userv2'"
    
    if is_number "$userv1" && is_number "$userv2"; then
        # Both numeric -> arithmetic is possible
        sum=$(echo "$userv1 + $userv2" | bc)
        prod=$(echo "$userv1 * $userv2" | bc)
        diff=$(echo "$userv1 - $userv2" | bc)
        echo "the sum of '$userv1' and '$userv2' is $sum"
        echo "the product of '$userv1' and '$userv2' is $prod"
        echo "the difference of '$userv1' and '$userv2' is $diff"
        
        if [ "$userv2" == "0" ]; then
            echo "Error: Division by zero is not allowed."
        else
            div=$(echo "scale=4; $userv1 / $userv2" | bc)
            echo "the division of '$userv1' by '$userv2' is $div"
        fi
    else
        #At least one operand is character/string -> arithmetic not possible
        echo "Error: Cannot add/multiply/subtract/divide non-numeric values."
        echo "'$userv1' and/or '$userv2' is a character/string, not a number."
    fi
    
    # Reverse order printing always works regardless of type
    echo "Reversed userv1: $(reverse_string "$userv1")"
    echo "Reversed userv2: $(reverse_string "$userv2")"
    
    read -p "Run again? (y/n): " again
    [[ "$again" == "y" || "$again" == "Y" ]] || break
done

echo "Exiting. All type combinations tested by running with:"
echo " int & int, int & real, int & char/string,"
echo " real & real, real & char/string, char/string & char/string"