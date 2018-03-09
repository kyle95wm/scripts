#!/bin/bash
# This script is to demonstrate the use of functions
# The first function issues the "who" command and function two issues the "ls -l" command

function menu {
echo "=====MENU====="
echo "1) Call the first function"
echo "2) Call the two function"
echo "3) Exit"
}

function menu_error {
echo "$REPLY is not a valid entry according to the script! Please try again."
}

function menu_prompt {
read -rp "Please enter a number: "
}

function first {
who
}

function two {
ls -l
}

echo "This script demonstrates the simple use of functions."
echo "Please look at this script in nano to get a full understanding"
menu # Calls the menu functions
menu_prompt # Calls a function to prompt the user for input
until [ "$REPLY" -le "3" ] ; do #Until test is less than or equal to "3"
clear # Clear the screen
menu # Call the menu function again
menu_error # Calls a function to let the user know their entry was invalid
menu_prompt # Calls a function to prompt the user for input
done
if [ "$REPLY" == "1" ] ; then
	first # Calls the function we labled "first"
fi

if [ "$REPLY" == "2" ] ; then
	two # Calls the "two" function
fi

if [ "$REPLY" == "3" ] ; then
	exit
fi
