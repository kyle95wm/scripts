#!/bin/bash
function usage {
echo "Usage: $0 <arg>"
echo "Type --help for list of args"
}
# This script shows the usage of arguments on the command line

# Arguments are useful for giving users the option to execute "special" options from the command line
# Bash uses $1-$9 (I think that's all bash uses I'm not sure but feel free to correct me)
# to pick up on how many arguments the user throws at the script. From here. we can tell the script what to do in various situations when arguments are supplied

if [ "$1" == "" ] ; then # This tells the script to call our usage function if our first argument is blank
	usage
fi
if [ "$#" -gt "1" ] ; then # This if statement tells the script that if more than 1 argument is supplied, that it should tell the user to only supply one argument.
	echo "You've supplied $# more than arguments but the script only wants 1"
fi
if [ "$1" == "--help" ] ; then # This if statement is used to "list" our arguments to the user if they enter --help
	echo "-l - lists the files and directories"
	echo "-w - show who's logged in"
else
	usage # If the user specifies anything else, our usage function is called
# We can of course use a bunch of elif statements for various arguments or more if statements:
fi
if [ "$1" == "-l" ] ; then
	echo "Listing the files in $PWD....."
	echo
	echo
	ls
fi
# Now let's provide a list of commands for our -w argument
if [ "$1" == "-w" ] ; then
	echo "Here's who's logged in to your system. Feel free to boot off anyone you don't recognize"
	who
fi


