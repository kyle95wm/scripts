#!/bin/bash

# This script will check to see if the host can ping the router.
# If the ping fails, shut down, then bring back up the interface designated as eth0

if ! ping 192.168.101.100 -c4 ; then
	# We first shut down eth0
	# After eth0 is shut down, we forcefully bring it back up
	ifdown eth0 && ifup --force eth0
else
	# We do noting if the network is okay
	echo "PBX is OK"
fi
