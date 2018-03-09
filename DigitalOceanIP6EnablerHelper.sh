#!/bin/bash

# This script is based off of the following tutorial and many of its comments: https://www.digitalocean.com/community/tutorials/how-to-enable-ipv6-for-digitalocean-droplets

# This script will help you enable IPV6 successfuly on your Digital Ocean server.

# THIS SCRIPT COMES WITH NO WARRENTY. YOU ARE RESPONSIBLE FOR ANY DAMANGE THAT IS DONE TO YOUR SERVER FROM THIS SCRIPT.

# BACK UP ALL YOUR DATA FIRST (snapshots) BEFORE YOU RUN THIS SCRIPT

echo "This script is designed to enable IP Version 6 on your Digital Ocean droplet. If IPV6 is not supported in your data centre, do not run this script."

echo "THIS SCRIPT COMES WITH NO WARRENTY!!"

read -rp "Type AGREE to continue. Otherwise, press ENTER to quit.: " eulaaccept

if [ "$eulaaccept" == "AGREE" ] ; then
	echo "Okay! Remember, if anything bad happens to your server, don't come crying to me."
else
	exit 1
fi
echo "Now some information:"
echo "Your Public IP6 Address is:"
curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv6/address
echo
echo "Your Public IP6 Gateway is:"
curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv6/gateway
echo
echo "Your IP6 CIDR is:"
curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv6/cidr
echo
echo "You must make sure the info is correct in all 3 parts"
read -rp "Do the Public, Gateway and CIDR check out? [y/n]: " check

if [ "$check" == "y" ] ; then
echo "backing up the interfaces file now...."
cp /etc/network/interfaces /etc/network/interfaces.orig
echo "Okay.....Setting up your interface file now....."
echo "You're going to have to comment out the 'dns-nameservers' part on your ipv4 interface."
cat >>/etc/network/interfaces <<EOF
#IPV6 info added by script
iface eth0 inet6 static
        address $(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv6/address)
        netmask $(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv6/cidr)
        gateway $(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv6/gateway)
        autoconf 0
        dns-nameservers 2001:4860:4860::8844 2001:4860:4860::8888 8.8.8.8
EOF
echo "Done!"
echo "You should maybe restart your server now...."
fi
exit 0
