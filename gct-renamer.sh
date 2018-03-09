#!/bin/bash

# Variables
menu="" # Variable used with user input in the menu system


# Functions - This will make it easier to call functions such as the menu for example

function menu {
echo "===MENU==="
echo "1) Swap VR into Mario Kart Wii GCT - This allows you to use the VR GCT in Mario Kart Wii"
echo "2) Swap Character changer into Mario Kart Wii GCT - This allows you to use character changer in Mario Kart Wii"
echo "Anything else=exit"
}

function prompt {
read -rp "Please enter a number from the menu, or anything else to exit: " menu
}

# The following function will check the user's input and decide a course of action based on that input
function menu_check {
if [ "$menu" == "1" ] ; then
	vr_swap # This will call our "vr_swap" function
fi

if [ "$menu" == "2" ] ; then
	ch_swap # This will call our "ch_swap" functin
fi
}

# The following function will only be triggered if a file doesn't exist
function error {
echo "Error! Returning to menu"
sleep 1s # Pause for one second
clear # Clear the screen of all content
menu # Calls the menu
prompt # Calls the menu's prmot
menu_check # Call menu check function
}

# This function will first check to see if the RMCE01.gct.vr file DOES NOT exist.
# If this is the case, it will call the error function. Otherwise it will rename and swap out the files
function vr_swap {
if [ ! -f "./RMCE01.gct.vr" ] ; then
	error # Calls error function if file doesn't exist
else
	echo "Re-naming 'RMCE01.gct' to 'RMCE01.gct.ch'"
	sleep 2s # Pause for two seconds to let th user read script output
	mv "./RMCE01.gct" "./RMCE01.gct.ch" # Rename RMCE01.gct file to RMCE01.gct.ch
	echo "Re-naming 'RMCE01.gct.vr' to 'RMCE01.gct'"
	sleep 2s # Pause for two seconds
	mv "./RMCE01.gct.vr" "./RMCE01.gct" # Renames the RMCE01.gct.vr file to RMCE01.gct
	sleep 2s # Pause for two seconds
	echo "-done-" # Tells the user the task is complete
	exit # Exits the script
fi
}
# This function will first check to see if the RMCE01.gct.ch file DOES NOT exist.
# If this is the case, it will call the error function. Otherwise it will rename and swap out the files
function ch_swap {
if [ ! -f "./RMCE01.gct.ch" ] ; then # Check if RMCE01.gct.ch DOES NOT EXIST
	error # Calls error function if this is true
else
	echo "Re-naming 'RMCE01.gct' to 'RMCE01.gct.vr'"
	sleep 2s # Pause for two seconds
	mv "./RMCE01.gct" "./RMCE01.gct.vr" # Rename RMCE01.gct to RMCE01.gct.vr
	echo "Re-naming 'RMCE01.gct.ch' to 'RMCE01.gct'"
	sleep 2s # Pause for two seconds
	mv "./RMCE01.gct.ch" "./RMCE01.gct" # Rename RMCE01.gct.ch to RMCE01.gct
	sleep 2s
	echo "-done-"
	exit
fi
}



# The purpose of this script is to re-name your GCT files so you can alternate your VR regen and your racing GCT.
# This script must be run from your SD card's codes folder

echo "This script will assist in renaming your GCT files between VR and character changer setups"

menu # Calls the first function - this is the menu
prompt # Prompt the user for input
menu_check # Initiates the menu answer checks based on user input
