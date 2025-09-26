#!/bin/bash
# ./10Rip.sh <URL>

# VARS

url="$1"
user="" # Your 10Play email
pass="" # Your 10Play password
ff="$(which ffmpeg)" # Location of ffmpeg
yt="$(which yt-dlp)" # Location of yt-dlp

# Check if 10Play login is filled out
if [ -z "$user" ] && [ -z "$pass" ] ; then
	echo "Hey, it looks like you haven't filled out your 10Play account info."
	echo "Please edit this file and fill out the user and pass variables at the top."
	exit 1
fi

# Check if ffmpeg is installed
if [ -z "$ff" ] ; then
	echo "Looks like ffmpeg is not installed."
	echo "Please install it and try again."
	exit 1
fi

# Check if we have yt-dlp installed on the system
if [ -z "$yt" ] ; then
	echo "Looks like you don't have yt-dlp installed."
	echo "Please see installation instructions at: https://github.com/yt-dlp/yt-dlp"
	exit 1
fi
# The main command
yt-dlp "$url" --username $user --password $pass --ffmpeg-location "$ff" --downloader aria2c
