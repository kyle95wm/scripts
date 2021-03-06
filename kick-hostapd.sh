#!/bin/bash
#Kick any device from your hostapd wi-fi network
clear #clears the screen
if [ "$(id -u)" != "0" ]; then
	echo "You need to be root for parts of this script to run properly."
	echo "Consider using sudo to run this script"
	exit 1
fi
hostapd_cli all_sta
echo "Please input the MAC address you'd like to kick"
read -re MAC
echo "Kicking $MAC now..."
hostapd_cli deauthenticate "$MAC" >/dev/null
exit 0
