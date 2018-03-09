#!/bin/bash

# This script will allow you to dump your phpbb's database and compress it
# in to a gzip file

db_name=""
sql_user=""
sql_pass=""

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
echo "Dumping $db_name into $db_name.gz NOW"
if ! mysqldump -u "$sql_user" -p"$sql_pass" --default-character-set=utf8 "$db_name" | gzip > "$db_name.gz" ; then
	echo "Uh-oh! Something went wrong. Please make sure your database name, sql username and password are correct."
	exit 1
else
	echo "DONE!"
fi
