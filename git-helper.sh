#!/bin/bash

# The goal of this script is for git to help you with comon tasks
# I suggest placing this script inside of your git clone you're working with.

#Variables
###########################
###########################

# Functions

function menu {
	echo "=====GIT Helper Menu====="
	echo
	echo "The available menu options are:"
	echo "0) Exit"
	echo "1) Init - This will allow you to make $PWD a local git repository allowing you to track changes"
	echo "2) Clone - Clone a remote repository - You will be asked how you'd like to clone (http, ssh, https, etc)"
	echo "3) Pull - Update your local copy to the latest version on GitHub"
	echo "4) Add - Add a file to be staged for a commit"
	echo "5) Add ALL Files - Add every (changed) file to be staged for a commit on GitHub"
	echo "6) Write a commit comment - You will open up in a text editor where you can write your comments."
	echo "7) Push - Push your commits to GitHub"
	echo
	read -rp "Please pick a number to start or press 'x' to quit: "
}

function pkg_check {
	dpkg -L git >/dev/null
}

function pkg_install {
	sudo apt-get install git
}

function git_clone {
	git clone 
}


#Main
echo "Welcome to the git helper script"
echo "For more info please read the comments in the file"
sleep 2s
echo "Checking for git package....."
if ! pkg_check ; then
	echo "Git package not found!"
	echo "Installing the package...."
	pkg_install
else
	echo "Package found!"
fi
sleep 2s
menu
until [ "$REPLY" -le "7" ] ; do
	clear
	sleep 2s
	menu
done
if [ "$REPLY" == 0 ] ; then
	exit
fi
if [ "$REPLY" == 1 ] ; then
	################################
	# Beginning of git init options
	################################
	echo "Right now you are in: $PWD."
	read -rp "Would you like to continue with git init? [y/n] "
fi
if [ "$REPLY" == "y" ] ; then
	git init
fi
if [ "$REPLY" == "n" ] ; then
	echo "Please copy this script to the directory where you want to run git init."
fi
#################
# End of git init
#################

if [ "$REPLY" == 2 ] ; then
	################################
	# Beginning of clone options
	################################
	echo "There are many different ways to clone a github repo."
	echo "[https] This is usually the default way to clone a git."
	echo "[http] This is like https but less secure."
	echo "[ssh] This is the most secure way - this should only be used with git repos you own"
	echo "NOTE: An SSH keypair is required to use 'ssh'."
	read -rp "Please Pick an option (type exactly what you see in the square brackets"
fi

if [ "$REPLY" == "https" ] ; then
	echo "In order to git clone, this script has automatically typed 'git clone' for you."
	read -rp "Please type the full URL of the remote repo to clone: " clonelink
	git_clone "$clonelink"
	exit
fi

if [ "$REPLY" == "http" ] ; then
        echo "In order to git clone, this script has automatically typed 'git clone' for you."
        read -rp "Please type the full URL of the remote repo to clone: " clonelink
        git_clone "$clonelink"
        exit
fi

if [ "$REPLY" == "ssh" ] ; then
        echo "In order to git clone, this script has automatically typed 'git clone' for you."
        read -rp "Please type the SSH clone URL: " clonelink
        git_clone "$clonelink"
        exit
fi
	#############################
	# Ending of clone options
	#############################

if [ "$REPLY" == 3 ] ; then
	git pull
	exit
fi

if [ "$REPLY" == 4 ] ; then
	read -rp "Please provide the name of the file that you wish to add to the stage: " file
	git add "$file"
fi

if [ "$REPLY" == 5 ] ; then
	git add -A
fi

if [ "$REPLY" == 6 ] ; then
	git commit
fi

if [ "$REPLY" == 7 ] ; then
	git push
fi
exit
