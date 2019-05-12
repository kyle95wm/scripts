#!/bin/bash

# This script will check to see if the host can ping the router.
# If the ping fails, shut down, then bring back up the interface designated as eth0

if ! /bin/ping 192.168.101.100 -c4 ; then
	# We first shut down eth0
	# After eth0 is shut down, we forcefully bring it back up
	/sbin/ifdown eth0 && /sbin/ifup --force eth0
else
	# We do noting if the network is okay
	/bin/echo "PBX is OK"
fi
