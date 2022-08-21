#!/bin/bash

echo "Connecting to the VPN as user $( whoami )"

if [ -f /response.txt ]; then
  export VPN_PASSWORD="$1"

  cat /response.txt | envsubst '$VPN_PASSWORD' | /opt/cisco/anyconnect/bin/vpn -s && \
  unset VPN_PASSWORD && \
  echo "Enjoy your VPN connection!" && \
  tail -f /dev/null
else
  /opt/cisco/anyconnect/bin/vpn
fi

