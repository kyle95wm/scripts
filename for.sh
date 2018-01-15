#!/bin/bash
# This is an example for loop.
# This loop will print each number in variable $number on a new line.
number="1 2 3 4" # Each number is a new argument
for n in $number ; do # For every number in $number - we assign $n to print each number
echo "$n" # Print each number using $n as the variable instead of $number
done # Finish the loop
