#!/bin/bash

# This if statement will check the status of a command.
# To keep it simple, we'll use True/False.
# We will also test if we have internet connectivity.

# First, let's test if true.

if "True" ; then
	echo "We returned true!"
fi

# Check if False
if "False" ; then
	echo "We're false!"
fi

# Now let's check internet connectivity
if curl -s icanhazip.com ; then
	echo "Internet connection is OK"
elif ! curl -s icanhazip.com ; then
	echo "Internet is KO"
fi
