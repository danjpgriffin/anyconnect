#!/bin/bash
cp /etc/resolv.conf /etc/resolv.conf.bak
umount /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf

sysctl net.ipv4.conf.all.forwarding=1

/fix-firewall.sh &
/start-traps.sh &

/opt/cisco/anyconnect/bin/vpnagentd
/opt/cisco/anyconnect/bin/vpn

