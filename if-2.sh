#!/bin/bash

one=not1 # The condition in the if statement won't be true
two=2 # This will return as true for the second condition

# The following if statement will become true if at least one of the conditions are met.

if [ $one == 1 ] || [ $two == 2 ] ; then
	echo "True"
else
	echo "False"
fi

# This if statement relies on both tests returning true.

if [ $one == 1 ] && [ $two == 2 ] ; then
	echo "Both values returned true"
else
	echo "At least one variable MUST be true. 
	The first variable is $one which should be 1.
	The second variable is $two when it should return 2."
fi
