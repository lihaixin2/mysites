nano list-purecon-allip.sh
#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

export PATH
country_file=purevpn.txt
rm -rf allip.txt
#IPS=$(egrep -v "^#|^$" $country_file | head -n 2)
    while read iplist
     do 
                        echo $iplist
                        country=`echo $iplist | awk {'print $1'}`
			countrydomain=`echo $iplist | awk {'print $2'}`
			countryip=`dig $countrydomain +short | grep -v '[a-z]'`
                        sleep 2
                        echo $country $countryip >>allip.txt
                        echo $countrydomain
                        echo $countryip
     done <$country_file
