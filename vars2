#!/bin/bash

# Here's another script demonstrating variables but instead, we will be using comments instead of strings of text

# Let's set up our variable for showing the IP address.

# Later on, we can send the command output into a file

# Allow me to demonstrate:

ipaddr=$(hostname -I) # This is a special kind of variable. The "$" outside the brackets are required to make the comment work, and then output that command as a variable.

echo "This script will show you what your IP is"
echo "Let's call our IP variable"
echo "Your IP address is $ipaddr"

# Now let's use cat to create a file with this valuable piece of info:

cat >/tmp/secret-info <<EOF
This is a top secret file and should be secured. Your machine's IP address is:
$ipaddr
EOF
echo "done!"
