#!/bin/bash
cp /etc/resolv.conf /etc/resolv.conf.bak
umount /etc/resolv.conf
cp /resolv.conf /etc/resolv.conf

sysctl net.ipv4.conf.all.forwarding=1
/fix-firewall.sh &

/start-traps.sh &

/opt/cisco/anyconnect/bin/vpnagentd
/opt/cisco/anyconnect/bin/vpn

