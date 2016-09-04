#!/bin/bash

# The purpose of this script is to aid in creating a DigitalOcean server for the IncrediblePBX installation without going through the web control pannel

# This script will assume the user has already configured doctl with their API access token.


# Check if root user
if [ $UID != 0 ] ; then
	echo "In order for this script to run properly, you must be running it as the root user. The reason for this is so that in the event you don't"
	echo "have doctl installed, this script can download it, unpack it, and move it to a directory in your PATH variable."
	echo "Please try again."
	exit 2
fi

# We will check to see if doctl is installed into one of our $PATH directories
which doctl >/dev/null
if [ $? != 0 ] ; then
	echo "The doctl script was not found in either of the following directories:"
	echo "$PATH"
	sleep 3s
	echo "Downloading doctl from GitHub...."
		# Download the doctl script while piping it into tar so we don't leave a tarball lying around
	curl -L https://github.com/digitalocean/doctl/releases/download/v1.4.0/doctl-1.4.0-darwin-10.6-amd64.tar.gz | tar xz
	mv ./doctl /usr/local/bin
	which doctl >/dev/null
	if [ $? == 0 ] ; then
		echo "doctl install successful!"
	else
		echo "doctl install failed!"
		exit 1
	fi
	# Fix permissons for doctl
	chown root:wheel /usr/local/bin/doctl
	echo "You will now be asked for your DigitalOcean API key below. Make sure you have it handy!"
fi

read -p "Do you have your API key set up for doctl? [y/n]: " apiquestion
if [ $apiquestion == n ] ; then
	echo
	doctl auth init
fi
doctl compute image list-distribution
read -p "Please enter the SLUG ID for the version of CentOS you woud like to use. I would recommend CentOS 6.8 x64, so enter centos-6-x64: " serveros
doctl compute region list
read -p "Please enter SLUG value for the region you would like your server to be in. For example you can enter nyc1.: " serverlocation
doctl compute size list
read -p "Please enter the size you would like for your server. Incredible can run on the base 512mb droplet, but you will need to create a swap file.: " serversize
read -p "Please enter the host name you would like to use for your server: " serverhostname
doctl compute ssh-key list
read -p "Please enter the SSH key fingerprint you would like to use for your server. If you don't have one, what's wrong with you?: " sshfinger
echo 
echo "Thank you for providing this information. Before I continue, I just want to make sure I have everything correctly:"
echo
echo "You told me you would like your server to be a $serversize server."
echo "For your distribution you would want to have $serveros as your Linux distro. Please note that Incredible works best on CentOS and is the most supported."
echo "Your server will have the hostname of $serverhostname"
echo "Your server will have your SSH key with fingerprint $sshfinger"
echo "Fially, you said you would like your server to be in the $serverlocation region. NOTE if you want DigitalOcean block storage, you should consider either using nyc1 or sf2"

read -p "Is the above information correct? [y/n]: " serverconfirm

if [ $serverconfirm == y ] ; then
	echo "Okay! Creating your server now. Please be patient"
	doctl compute droplet create $serverhostname --image $serveros --region $serverlocation --size $serversize --ssh-keys $sshfinger --wait
else
	echo "Please re-run this script and re-enter your choices. Goodbye!"
	exit 2
fi
