#!/bin/bash

file=""

if [ -z "$1" ] ; then
	echo "Usage: $0 [file-to-encrypt-or-decrypt]"
	exit 2
else
	file="$1"
fi

echo Please\ pick\ what\ you\ would\ like\ to\ do\ with\ the\ file\ "$file".
echo "1) Encrypt this file"
echo "2) Decrypt this file"
read -rp "Please enter 1 or 2: " opp

if [ "$opp" -eq "1" ] ; then
	openssl enc -aes-256-cbc -e -in "$file" -out "$file"_encrypted
	echo Your\ file\ has\ been\ encrypted\ as\ "$file"_encrypted.
elif [ "$opp" -eq "2" ] ; then
	openssl enc -aes-256-cbc -d -in "$file" -out "$file"_decrypted
	echo Your\ file\ has\ been\ decrypted\ as\ "file"_decrypted.
fi
