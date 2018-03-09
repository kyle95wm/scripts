#!/bin/bash

# This script was originally intended to be used on the Netgear READYNAS system

# This script will assume everything will work successfully.

# Please refer to https://community.netgear.com/t5/New-to-ReadyNAS/Installing-and-running-OpenVPN-boot-PrivateInternetAcces/td-p/941794

# for a written guide. Also you should refer to the last post on the 4th page

# as this is what this script will be based on for the most part.

echo "Checking current directory...."
if ! pwd |grep /etc/openvpn ; then
	echo "This script will assume you already have SSH enabled on your ReadyNAS"

	echo "NOTE: Enabling SSH may void your warrenty and Netgear will deny service."

	read -rp "Continue? [y/n]: "

	if [ "$REPLY" == "y" ] ; then
		echo "Great!"
		apt-get update
		apt-get install openvpn nano -y
		echo "OpenVPN install complete!"
		echo "ITS NOT OVER YET! Please move this script to /etc/openvpn and then re-run it."
		exit
	fi
else
	echo "We can now continue on to the next step!"
	wget https://www.privateinternetaccess.com/openvpn/openvpn.zip
	unzip openvpn.zip
	echo "OpenVPN files for PIA download complete!"
	echo "I will now create a file named userpass.file"
	echo "This will have your PIA username and password inside of it"
	echo "which you will enter below:"
	read -rp "Please enter your PIA username - this is the username you use to log in to the website to manage your account: " piauser
	read -rp "Please enter your PIA password: " piapass
	cat > /etc/openvpn/userpass.file <<EOF
$piauser
$piapass
EOF
	ls |grep .ovpn
	read -rp "Please copy/paste the name of the ovpn file you wish to use(includes the .ovpn extension): " conffile
	sed s/"auth-user-pass"/"auth-user-pass userpass.file"/ "$conffile" > My.ovpn
	mv My.ovpn client.conf
	/etc/init.d/openvpn start
	echo "Done!"
fi
