#!/bin/sh
# wget https://public-dns.info/nameserver/us.txt
PATH=/sbin:/usr/sbin:/bin:/usr/bin

export PATH
country_file=us.txt
rm -rf allip.txt
#IPS=$(egrep -v "^#|^$" $country_file | head -n 2)
    while read iplist
     do 
               #         echo $iplist
               #         country=`echo $iplist | awk {'print $1'}`
	       #		countrydomain=`echo $iplist | awk {'print $2'}`
	       		countryip=`dig mx.prcdn.net -t CNAME @$iplist +short`
               #         sleep 1
                        echo $countryip >>allip.txt
               #         echo $countrydomain
               #         echo $countryip
     done <$country_file
sort allip.txt | uniq -c >allipone.txt
