#!/bin/bash

NV-FILE="/tmp/IncrediblePBX13-12R.sh"
MYVER="/root/ipbx-installer/IncrediblePBX13-12R.sh" # My version of the installer

# Original code by Dennis Simpson
# Modified by Kyle Warwick-Mathieu
echo "Checking if script is up to date, please wait"
cd /tmp || exit
wget http://incrediblepbx.com/incrediblepbx13-12.2-centos.tar.gz
tar zxvf incrediblepbx*

diff $MYVER $NV-FILE >& /dev/null
if [ "$?" != "0" -a -s $NV-FILE ]; then # If the exit code is not 0 (in other words if the file is different)
	mv $NV_FILE $MY-VER # Rename update file to the script you're running
	chmod +x $MY-VER # Change the mode on the newly renamed file
	cd /root/ipbx-installer/ || exit
	git add -A
	git commit -m "Automated update"
	git push -f
	exit
else
	rm $NV_FILE # If no updates are available, simply remove the file
fi

