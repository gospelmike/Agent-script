#!/bin/bash

#Descrition: Full server inventory
#Author: Michael
#Date: July 28, 2021

if [ ${USER} != root]
then
echo "You need root access to run this"
exit 1

else

echo "The OS running and version is"
cat /etc/*release | grep PRETTY_NAME= | awk -F_ '{print $2}'| awk -FNAME= '{print $2}'
echo
echo "The size of memory in Megabyte"
free -m | tail -2 | grep Mem: | awk '{print $2}'
echo
echo "The size of hard drive"
lsblk | grep disk
echo
echo "The CPU speed in MegaHertz"
lscpu | grep "CPU MHz" | awk '{print $3}'
echo
echo "The kernel version"
uname -r
echo
echo "The system bit"
arch | awk -F_ '{print $2}'
echo
echo "The hostname"
hostname
echo
echo "The ip address"
ip addr | grep enp0s3 | tail -1 | awk '{print $2}'
echo "All opened ports"
netstat -tulpn | grep LISTEN
echo
echo "The DNS"
cat /etc/resolv.conf | grep nameserver
echo
echo "The manufacturer"
lshw -c system | grep vendor | awk '{print $2}'
echo
echo "Is the system virtual or physical"
lshw -c system | tail -1 | awk '{print $2}' | awk -Ffamily= '{print $2}'
echo
echo "the MAC address"
ip addr | grep link/ether | head -1 | awk '{print $2}'

fi
