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
read -p "Please enter a number from the menu, or anything else to exit: " menu
}

function menu_check {
if [ "$menu" == "1" ] ; then
	vr_swap
fi

if [ "$menu" == "2" ] ; then
	ch_swap
fi
}

function error {
echo "Error! Returning to menu"
sleep 1s
clear
menu
prompt
menu_check
}

function vr_swap {
if [ ! -f "./RMCE01.gct.vr" ] ; then
	error
else
	echo "Re-naming 'RMCE01.gct' to 'RMCE01.gct.ch'"
	sleep 2s
	mv "./RMCE01.gct" "./RMCE01.gct.ch"
	echo "Re-naming 'RMCE01.gct.vr' to 'RMCE01.gct'"
	sleep 2s
	mv "./RMCE01.gct.vr" "./RMCE01.gct"
	sleep 2s
	echo "-done-"
	exit
fi
}
function ch_swap {
if [ ! -f "./RMCE01.gct.ch" ] ; then
	error
else
	echo "Re-naming 'RMCE01.gct' to 'RMCE01.gct.vr'"
	sleep 2s
	mv "./RMCE01.gct" "./RMCE01.gct.vr"
	echo "Re-naming 'RMCE01.gct.ch' to 'RMCE01.gct'"
	sleep 2s
	mv "./RMCE01.gct.ch" "./RMCE01.gct"
	sleep 2s
	echo "-done-"
	exit
fi
}



# The purpose of this script is to re-name your GCT files so you can alternate your VR regen and your racing GCT.
# This script must be run from your SD card's codes folder

echo "This script will assist in renaming your GCT files between VR and character changer setups"

menu
prompt
menu_check
