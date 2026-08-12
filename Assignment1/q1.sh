#!/bin/bash
#q1_args.sh
#Usage: ./q1_args.sh To the OS Laboratory at Alpha Lab Welcome
echo "Number of arguments: $#"
echo "All arguments: $@"
#Original order (as given):
#$1=To $2=the $3=OS $4=Laboratory $5=at $6=Alpha $7=Lab $8=Welcome
#Desired output: "Welcome To the OS Laboratory at Alpha Lab"
echo "Reordered: $8 $1 $2 $3 $4 $5 $6 $7"