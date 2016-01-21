#!/bin/bash

# This script is designed to insert your backed up database file
# into SQL
db_name=""
sql_user=""
sql_pass=""

echo "Please answer the following questions:"
until [ ! -z "$db_name" ] ; do
	read -p "What is the name of your database? Most of the time it's phpbb: " db_name
done
until [ ! -z "$sql_user" ] ; do
	read -p "Please enter your sql username. Most people just use root: " sql_user
done
until [ ! -z "$sql_pass" ] ; do
read -p "Please enter your sql password: " sql_pass
done
echo "Inserting backed up database into SQL...."
gunzip < $db_name.gz | mysql -u $sql_user -p$sql_pass --default-character-set=utf8 $db_name
if [ $? != "0" ] ; then
	echo "Uh-oh! Something went wrong. Please make sure your database name, sql username and password are correct."
	exit 1
else
	echo "DONE!"
