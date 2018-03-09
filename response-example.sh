#!/bin/bash
#This is a sample script demonstrating if statements
#If you answer is "y" then the "yay!" message will be printed
#If your answer is "n" then the "you said no!" message will be printed.
read -rp "What is your answer? [y/n]" #Reads a user's response for y or n
if [ "$REPLY" != "y" ] ; then #If the response is not "y" then print the message "you said no!"
	echo "You said nn!" #Print this message if the user's response is not "y"
else #If the user's response is "y" then......
	echo "yay!" #Print this message is the response is "y"
fi #Ends the if statement
