#!/usr/bin/env bash
# This script will delete call recordings every month, but will only delete the recordings for
# the current year, and 3 months prior to running the script.
# For example, if the script were run in April, all call recordings for January will be deleted.
# Additionally, if the script is run with an argument of "last", the script will
# check to see if last year's folder exists, and is empty. If both conditions are met, the script
# deletes the previous year's empty folder

#### EXAMPLE JOB TO PUT INTO /etc/crontab ####
# Run script with no arguments (normal mode) on the first day of every month at 9:30 AM local time
# 30 9 1 * * root /root/purge-recordings.sh > /dev/null 2>&1
# Run script with "last" argument (purge last year's folder if empty) at 10:30 AM local time
# on the first day of the next year
# 30 10 1 1 * root /root/purge-recordings.sh last > /dev/null 2>&1

#set -x # Un-comment to get a complete trace - used for debugging
dir="/var/spool/asterisk/monitor" # The call recordings directory
year="$(date -d '-3 months' +%Y)" # Get year from 3 months ago in XXXX form
month="$(date -d '-3 months' +%m)" # Get month number from 3 months ago in YY form
lastyear="$(date -d '-1 year' +%Y)" # Get last year's year number

# Check if "last" was specified as an argument.
if [ "$1" == "last" ] ; then
    if [ -d "$dir/$lastyear" ] ; then # Check for a directory from last year
        if [ -z "$(ls -A "$dir/$lastyear")" ] ; then # This checks if folder is completly empty
            if rm -rf "${dir:?}/${lastyear:?}" ; then # Test if deletion command exits with 0 status code
                # Send an email alert to notify the admin about successful deletion
                echo "Hi, just letting you know that the empty directory for $lastyear was deleted for server $(hostname -f) with IP $(curl -s icanhazip.com)." | mail -s lastyear kyle95wm@gmail.com
            fi
        fi
    fi
    # We will exit to prevent the script from running any further from this point when "last"
    # is provided as an argument. We only want this portion of the script to run in this particular case.
    # If the script were to run normally, this entire section will not be executed.
	exit
fi

if [ -d "$dir/$year/$month" ] ; then # Check if month's directory does exist
	# If True, delete the directory
	if rm -rf "${dir:?}/${year:?}/${month:?}/" ; then # Did our deletion complete successfully?
		# If True, send an email.
		# We also grab the month name instead of number.
		# For example, a message might say "Hi, just letting you know that the
		# recordings for the month of January were purged.
		echo "Hi, just letting you know that the recordings for the month of $(date -d '-3 months' +%b) have been purged." | mail -s purged kyle95wm@gmail.com
	else
		# If the job failed, we will send a different email using the same concept as before.
		# We will also tell the administrator which server failed via its IP address.
		echo "Hi, just letting you know that the recordings for the month of $(date -d '-3 months' +%b) were NOT purged. Please log into server $(curl -s icanhazip.com) to investigate." | mail -s FAILED kyle95wm@gmail.com
	fi
else
	echo "Hi, just letting you know that there are no recordings for the month of $(date -d '-3 months' +%b) for server $(hostname -f) with IP $(curl -s icanhazip.com). Thank you!" | mail -s nothingtopurge kyle95wm@gmail.com
fi
