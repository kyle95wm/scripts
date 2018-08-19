#!/bin/bash

if [ "$(id -u)" != "0" ] ; then
	echo "Please run this script as root"
	exit 2
fi

if [ ! -f /etc/pihole/personal-adlists.list ] ; then
	touch /etc/pihole/personal-adlists.list
fi
# cat reads the contents of /etc/pihole/personal-adlists.list (A file which you create that just has blocklist URL's in it)
# cat also receives input from wget as the contents of wget is being thrown into cat as a "file"
# This ensures that one big list of blocklist URL's are being piped to tee with admin privledges into /etc/pihole/adlists.list.
cat /etc/pihole/personal-adlists.list <(wget -qO - https://v.firebog.net/hosts/lists.php?type=nocross 2> /dev/null) | sudo tee /etc/pihole/adlists.list
# Update the adlists
pihole -g
