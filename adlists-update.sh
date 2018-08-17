#!/bin/bash

#Variables
adlist='/etc/pihole/adlists.list'

#This is an array of the default lists
#Add to it as needed
default_lists[0]='https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
default_lists[1]='http://mirror1.malwaredomains.com/files/justdomains'
default_lists[2]='http://sysctl.org/cameleon/hosts'
default_lists[3]='https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist'
default_lists[4]='https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt'
default_lists[5]='https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt'
default_lists[6]='https://hosts-file.net/ad_servers.txt'
# TSPPRS - comment/un-comment as needed
default_lists[7]='https://tspprs.com/dl/abuse'
default_lists[8]='https://tspprs.com/dl/ads'
default_lists[9]='https://tspprs.com/dl/crypto'
default_lists[10]='https://tspprs.com/dl/drugs'
default_lists[11]='https://tspprs.com/dl/fraud'
default_lists[12]='https://tspprs.com/dl/fakenews'
default_lists[13]='https://tspprs.com/dl/gambling'
default_lists[14]='https://tspprs.com/dl/main'
default_lists[15]='https://tspprs.com/dl/malware'
default_lists[16]='https://tspprs.com/dl/misc'
default_lists[17]='https://tspprs.com/dl/phishing'
default_lists[18]='https://tspprs.com/dl/porn'
default_lists[19]='https://tspprs.com/dl/proxy'
default_lists[20]='https://tspprs.com/dl/ransomware'
default_lists[21]='https://tspprs.com/dl/scam'
default_lists[22]='https://tspprs.com/dl/spam'
default_lists[23]='https://tspprs.com/dl/suspicious'
default_lists[24]='https://tspprs.com/dl/torrent'
default_lists[25]='https://tspprs.com/dl/tracking'
default_lists[26]='https://tspprs.com/dl/spotify'
#Get Wally's list to add to the mix
wally_list=$(curl -L https://v.firebog.net/hosts/lists.php?type=tick)
#wally_list=$(curl -L https://v.firebog.net/hosts/lists.php?type=nocross)
#wally_list=$(curl -L https://v.firebog.net/hosts/lists.php?type=all)

#Write the defaults to the adlist
printf "%s\n" "${default_lists[@]}" > "$adlist"

#Add Wally's list to the file
echo "$wally_list" >> "$adlist"

#Load the new list
pihole -g
