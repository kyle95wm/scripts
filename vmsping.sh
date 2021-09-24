#!/bin/bash

for server in atlanta1 atlanta2 chicago1 chicago2 chicago3 dallas1 dallas2 denver1 denver2 fax1 fax2 houston2 losangeles1 losangeles2 losangeles3 losangeles4 newyork1 newyork2 newyork3 newyork4 newyork5 newyork6 newyork7 newyork8 sanjose1 sanjose2 seattle1 seattle2 seattle3 tampa1 tampa2 tampa3 tampa4 washington1 washington2 ws1 montreal1 montreal3 montreal4 montreal5 montreal6 montreal7 montreal8 montreal9 montreal10 toronto1 toronto2 toronto3 toronto4 toronto5 toronto6 toronto7 toronto8 toronto10 vancouver1 vancouver2 vancouver3 amsterdam1 london1 paris1 sydney1
do
	ping $server.voip.ms -t 1 > /dev/null
	if [ $? != 0 ] ; then
		echo "$server is down!"
	else
		echo "$server is up!"
	fi
done
