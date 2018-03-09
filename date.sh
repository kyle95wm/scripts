#!/bin/bash
# set -x # Un-comment to get a complete trace - used for debugging
dir="/var/spool/asterisk/monitor" # The call recordings directory
year="$(date -d '-3 months' +%Y)" # Get year from 3 months ago in XXXX form
month="$(date -d '-3 months' +%m)" # Get month number from 3 months ago in YY form
if [ -d "$dir/$year/$month" ] ; then # Check if month's directory does not exist
	# If True, delete the directory
	if rm -rf "${dir:?}/${year:?}/${month:?}/" ; then # Did our deletion complete successfully?
		# If True, send an email.
		# We also grab the month name instead of number.
		# For example, a message might say "Hi, just letting you know that the
		# recordings for the month of January were purged.
		echo "Hi, just letting you know that the recordings for the month of $(date -d '-3 months' +%M) have been purged." | mail -s purged kyle95wm@gmail.com
	else
		# If the job failed, we will send a different email using the same concept as before.
		# We will also tell the administrator which server failed via its IP address.
		echo "Hi, just letting you know that the recordings for the month of $(date -d '-3 months' +%b) were NOT purged. Please log into server $(curl -s icanhazip.com) to investigate." | mail -s FAILED kyle95wm@gmail.com
	fi
fi
