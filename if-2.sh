#!/bin/bash

one=not1 # The condition in the if statement won't be true
two=2 # This will return as true for the second condition

# The following if statement will become true if at least one of the conditions are met.

if [ $one == 1 ] || [ $two == 2 ] ; then
	echo "True"
else
	echo "False"
fi
