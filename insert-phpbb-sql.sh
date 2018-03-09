#!/bin/bash

# This script is designed to insert your backed up database file
# into SQL
db_name=""
sql_user=""
sql_pass=""
if [ $UID != "0" ] ; then
	echo "Please run this script as root."
	exit 1
fi
# Package checks
apt-get update
if ! dpkg -L apache2 &>/dev/null ; then
	apt-get install apache2 -y
fi
if dpkg -L pho7.1 &>/dev/nul ; then
True
fi
if ! dpkg -L php5 &>/dev/null ; then
	apt-get install php5 -y
fi
if ! dpkg -L phpmyadmin &>/dev/null ; then
	apt-get install phpmyadmin -y
fi
if ! dpkg -L mysql-client &>/dev/null ; then
	apt-get install mysql-client -y
fi
if ! dpkg -L mysql-server &>/dev/null ; then
	apt-get install mysql-server -y
fi
echo "Please answer the following questions:"
until [ ! -z "$db_name" ] ; do
	read -rp "What is the name of your database? Most of the time it's phpbb: " db_name
done
until [ ! -z "$sql_user" ] ; do
	read -rp "Please enter your sql username. Most people just use root: " sql_user
done
until [ ! -z "$sql_pass" ] ; do
read -rp "Please enter your sql password: " sql_pass
done
echo "create database $db_name" | mysql -u "$sql_user" -p"$sql_pass"
echo "Inserting backed up database into SQL...."
if ! gunzip < "$db_name.gz" | mysql -u "$sql_user" -p"$sql_pass" --default-character-set=utf8 "$db_name" ; then
	echo "Uh-oh! Something went wrong. Please make sure your database name, sql username and password are correct."
	exit 1
else
	echo "DONE!"
fi
