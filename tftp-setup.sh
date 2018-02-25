#!/bin/bash

# This script is designed to set up a TFTP server, which anyone can access


# Check if user is root

if [ $UID != 0 ] ; then
echo "Not root!"
exit 1
fi

# Check if OS has APT-GET

if [ -f "/etc/apt/sources.list" ] ; then
CANRUN="Y"
fi

if [ $CANRUN == "Y" ] ; then
# First let's update the system, and install the xinetd, tftpd and tftp
apt-get update && apt-get upgrade -y && apt-get install xinetd tftpd tftp -y

# Next let's insert our xinetd configuration for tftp

cat >/etc/xinetd.d/tftp <<EOF
service tftp
{
protocol        = udp
port            = 69
socket_type     = dgram
wait            = yes
user            = nobody
server          = /usr/sbin/in.tftpd
server_args     = /tftpboot
disable         = no
}
EOF

# Create a folder /tftpboot and set proper ownership with permissions so that the nobody group has access. 
# The files inside don't need special permissions.
mkdir /tftpboot
chmod -R 777 /tftpboot
chown -R nobody /tftpboot

service xinetd restart
if [ $? != 0 ] ; then
/etc/init.d/xinetd restart
fi
echo "Done!"
echo "Please reboot to make sure everything comes up properly."
fi
