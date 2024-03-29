#!/bin/bash
LOCALFILE="" # Grab the local file path
USER="" # The username of the remote host
HOST="" # The IP or FQDN of the remote host
REMOTEDIR="" # Directory of the remote host - can be an absolute path to a file
# The purpose of this script is to aid in using the rather complex SCP command

# Menu

echo "1) Copy file from local host to remote host"
echo "2) Copy file from remote host to local host"

read -rp "Please choose from the list by entering a number: " MENU

if [ "$MENU" == "1" ] ; then
	# BEGIN COPY FROM LOCALHOST TO REMOTE HOST
	read -rp "Please enter the FULL path of the file you would like copied to the remote server: " LOCALFILE
	#read -rp "Please enter the username of the remote host: " USER
	read -rp "Please enter the host you would like to use (IP or FQDN): " HOST
	read -rp "Please enter a directory on the REMOTE host to copy $LOCALFILE to: " REMOTEDIR
	echo "Copying $LOCALFILE as $USER to $HOST at $REMOTEDIR...."
	if ! scp -r "$LOCALFILE" "$HOST":"$REMOTEDIR" ; then
		echo "COPY FAILED!"
		exit 1
	fi
	# END COPY FROM LOCALHOST TO REMOTE HOST
fi

if [ "$MENU" == "2" ] ; then
	# BEGIN COPY FROM REMOTE HOST TO LOCALHOST
        read -rp "Please enter the FULL path of the file you would like copied from the remote server: " LOCALFILE
        #read -rp "Please enter the username of the remote host: " USER
        read -rp "Please enter the host you would like to use (IP or FQDN): " HOST
        echo "Copying $LOCALFILE as $USER from $HOST at $REMOTEDIR to LOCAL HOST at $HOME...."
	if ! scp -r "$HOST":"$LOCALFILE" "$HOME" ; then
        echo "COPY FAILED!"
        exit 1
    fi
	# END COPY FROM REMOTE HOST TO LOCAL HOST
fi
