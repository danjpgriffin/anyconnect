#!/bin/bash

cp /etc/resolv.conf /etc/resolv.conf.bak
umount /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf

sysctl net.ipv4.conf.all.forwarding=1

/fix-firewall.sh &
/start-traps.sh &

service dnsmasq start

/opt/cisco/anyconnect/bin/vpnagentd

sudo -Hiu atob /start-anyconnect-vpn.sh "$VPN_PASSWORD"

