#!/bin/bash
COUNT="0"
while [ "$COUNT" -le 4 ] ; do
	(( COUNT=COUNT+1 ))
    echo "Count is now at $COUNT out of 5"
    sleep 2s
done
echo "$COUNT"
