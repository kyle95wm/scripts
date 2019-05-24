#!/bin/bash

# This script will check to see if the host can ping the router.
# If the ping fails, shut down, then bring back up the interface designated as eth0

if [ $UID != 0 ] ; then
	echo "Script must be run as root."
	exit 1
fi

if ! /bin/ping 192.168.101.100 -c4 ; then
	# We first shut down eth0
	# After eth0 is shut down, we wait 5 seconds, then bring it back up
	/sbin/ifconfig eth0 down && /bin/sleep 5 && /sbin/ifconfig eth0 up
else
	# We do noting if the network is okay
	/bin/echo "PBX is OK"
fi
