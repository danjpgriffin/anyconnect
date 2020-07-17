#!/bin/bash
cp /etc/resolv.conf /etc/resolv.conf.bak
umount /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf

sysctl net.ipv4.conf.all.forwarding=1

/fix-firewall.sh &
/start-traps.sh &

service dnsmasq start

/opt/cisco/anyconnect/bin/vpnagentd

if [ -f /response.txt ]; then
  cat /response.txt | envsubst '$VPN_PASSWORD' | /opt/cisco/anyconnect/bin/vpn -s && \
  unset VPN_PASSWORD && \
  echo "Enjoy your VPN connection!" && \
  tail -f /dev/null
else
  /opt/cisco/anyconnect/bin/vpn
fi
