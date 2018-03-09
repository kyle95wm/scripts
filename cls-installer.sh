#!/bin/bash

# This script is used to install or uninstall if detected, a windows inspired cls command.

# Variables

install_option="" # We leave this blank for user input
uninstall_option="" # We leave this blank for user input

### FUNCTIONS ###

function root_check {
if [ $UID != "0" ] ; then
	echo "You must be root!"
	echo "Please run 'sudo $0'"
	exit 1
fi
}
function cls_init {
echo "Checking for the cls file...."
if [ -f /usr/local/bin/cls ] ; then
	echo "CLS has been detected on your system."
	cls_uninstall
else
	echo "CLS not found!"
	cls_install
fi
}

function cls_install {
echo "Welcome to the installer!"
echo "This is your last chance to back out!"
read -rp "Would you like to continue? [y/n] : " install_option
if [ "$install_option" == "y" ] ; then
clear
	echo "Installing cls file to '/usr/local/bin'...."
	echo "Creating the CLS file...."
	touch /usr/local/bin/cls
	sleep 1s
	echo "Now let's flag it so we can run it...."
	chmod a+x /usr/local/bin/cls
	sleep 1s
	echo "Adding the magic into the file to make it work....."
cat > /usr/local/bin/cls <<EOF
#!/bin/bash
clear
printf '\033[3J'
EOF
elif [ "$install_option" == "n" ] ; then
	echo "Exiting....."
	exit 0
else
	echo "Invalid entry!"
	exit 1
fi
}

function cls_uninstall {
echo "This part of the script will help you in uninstalling CLS."
if [ -f /usr/local/bin/cls ] ; then
	echo "I've detected CLS. This means the uninstall will work."
else
	echo "CLS can't be detected. Either CLS is not installed or you changed the location or file name."
	exit 1
fi
read -rp "Would you like to continue uninstalling CLS? [y/n ] : " uninstall_option

if [ "$uninstall_option" == "y" ] ; then
	echo "Removing CLS..."
	rm -r -f "/usr/local/bin/cls"
	sleep 1s
	echo "Doing some behind the scenes work...."
	type cls
	sleep 1s
	hash -d cls
	echo "Uninstall completed!"
elif [ "$uninstall_option" == "n" ] ; then
	echo "Good to know you find my command useful!"
	exit 0
else
	echo "Invalid entry!"
	exit 1
fi
}
### MAIN ###

echo "Thank you for running the CLS installer/uninstaller script!"
echo
echo "After running this script, you will be able to use cls to clear your scrren and the scrollback just like Windows does."
echo "I will run some checks before I install anything...."
root_check
cls_init
