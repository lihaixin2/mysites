#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
# file name is ip_route_boot_vultr.sh
# curl -sSL https://github.com/lihaixin2/mysites/raw/master/bash/ip_route_boot_vultr.sh |  bash
# 环境测试：vultr ubuntu 14:04 x86_64
# 1、vultr手工修改网卡/etc/network/interface信息后，最多3个ip
# 2、把上面命令放到开机/etc/rc.local里启动，访问那个公网ip走哪个ip出去
# 3、 docker应用ssr等需要使用--net host启动容器
# 4、softether docker后，分配使用172.16.*.0通过ip rule源路由出去

if [ -z "`grep eth0 /etc/iproute2/rt_tables`" ]; then
 echo "252     eth0 " >> /etc/iproute2/rt_tables
fi
if [ -z "`grep eth1 /etc/iproute2/rt_tables`" ]; then
  echo "251     eth0:1 " >> /etc/iproute2/rt_tables
fi

if [ -z "`grep eth1 /etc/iproute2/rt_tables`" ]; then
  echo "250     eth0:2 " >> /etc/iproute2/rt_tables
fi

if [ ! -f /usr/bin/sipcalc ]; then
apt-get update -y && apt-get install -y sipcalc
fi

ethname=eth0
ethip=$(ifconfig $ethname | grep "inet addr:" | awk '{print $2}' | cut -c 6-)
mask=$(ifconfig $ethname | grep "inet addr:" | awk '{print $4}' | cut -c 6-)
GW=$(netstat -r|grep default|cut -f 10 -d ' ');
netaddress=$(sipcalc $ethname | grep 'Network address' |awk '{print $4}')
netmaskbit=$(sipcalc $ethname | grep 'Network mask (bits)' | awk '{print $5}')
cdir=${netaddress}/${netmaskbit}
echo $cdir

ip route flush table $ethname
ip route add $cdir dev $ethname src $ethip table $ethname
ip route add 169.254.0.0/16 dev $ethname src $ethip table $ethname
ip route add default via $GW table  $ethname
ip rule add from $ethip table $ethname
ip route add 172.16.0.0/24 dev tap_default table  $ethname
ip rule add from 172.16.0.0/24 table  $ethname

ethname=eth0:1
ethip=$(ifconfig $ethname | grep "inet addr:" | awk '{print $2}' | cut -c 6-)
mask=$(ifconfig $ethname | grep "inet addr:" | awk '{print $4}' | cut -c 6-)
GW=$(netstat -r|grep default|cut -f 10 -d ' ');
netaddress=$(sipcalc $ethname | grep 'Network address' |awk '{print $4}')
netmaskbit=$(sipcalc $ethname | grep 'Network mask (bits)' | awk '{print $5}')
cdir=${netaddress}/${netmaskbit}
echo $cdir

ip route flush table $ethname
ip route add $cdir dev $ethname src $ethip table $ethname
ip route add 169.254.0.0/16 dev $ethname src $ethip table $ethname
ip route add default via $GW table  $ethname
ip rule add from $ethip table $ethname
ip route add 172.16.1.0/24 dev tap_tap1 table  $ethname
ip rule add from 172.16.1.0/24 table  $ethname

ethname=eth0:2
ethip=$(ifconfig $ethname | grep "inet addr:" | awk '{print $2}' | cut -c 6-)
mask=$(ifconfig $ethname | grep "inet addr:" | awk '{print $4}' | cut -c 6-)
GW=$(netstat -r|grep default|cut -f 10 -d ' ');
netaddress=$(sipcalc $ethname | grep 'Network address' |awk '{print $4}')
netmaskbit=$(sipcalc $ethname | grep 'Network mask (bits)' | awk '{print $5}')
cdir=${netaddress}/${netmaskbit}
echo $cdir

ip route flush table $ethname
ip route add $cdir dev $ethname src $ethip table $ethname
ip route add 169.254.0.0/16 dev $ethname src $ethip table $ethname
ip route add default via $GW table  $ethname
ip rule add from $ethip table $ethname
ip route add 172.16.2.0/24 dev tap_tap1 table  $ethname
ip rule add from 172.16.2.0/24 table  $ethname
