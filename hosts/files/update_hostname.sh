#!/bin/bash
HOSTNAME=$1
hostname $HOSTNAME
echo $HOSTNAME> /etc/hostname
IPADDR=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
echo $IPADDR >/tmp/ip_current
sed -i "s/127.0.0.1[[:space:]]localhost/127.0.0.1    localhost\n$IPADDR  $HOSTNAME.scilogonline.com $HOSTNAME\n/g" /etc/hosts
sed -i "s/127.0.1.1	vagrantup.com	vagrantup/$IPADDR  $HOSTNAME.scilogonline.com $HOSTNAME\n/g" /etc/hosts

