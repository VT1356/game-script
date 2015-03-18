#!/bin/bash
echo "Interface's name: "
read interface
green='\033[0;32m'
nomal='\033[0m'

ip=`ifconfig $interface | grep 'inet addr' | awk -F : '{print $2}' | awk '{print $1}'`
mask=`ifconfig $interface | grep 'inet addr' | awk -F : '{print $4}'`
gateway=`route -n | awk '{if ($1 == "0.0.0.0") print $2;}'`
mac=`ifconfig $interface | awk '/HWaddr/ {print $5}'`
leng=${#ip}

if [ $leng -ne 0 ]
then
  echo -e "${green}IPADDRESS: $ip${nomal}"
  echo -e "${green}GATEWAY: $gateway${nomal}"
  echo -e "${green}SUB NETMASK: $mask${nomal}"
  echo -e "${green}MAC ADDRESS: $mac${nomal}"
else
  echo -e "${green}Wrong Interface${nomal}"
fi
