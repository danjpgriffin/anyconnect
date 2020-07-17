## About
This project enables a linux host to run Cisco Anyconnect and Traps/Cortex in a docker container. The wrapper
script then routes selected network ranges to the VPN. Currently all DNS traffic is sent through the VPN

## To configure

All configuration is performed in the `config/` directory

* Obtain the AnyConnect linux installer program. Place in the file 'packages/anyconnect.tar.gz'
* Obtain the "Traps/Cortex" debian linux installer. Place in the file 'packages/cortex.deb' directory. 
* Create a config/resolv.template file containing the IP address of the container as nameserver and optionally the search domains you want to use. The container will forward DNS queries to the nameservers provided by the VPN connection or in interactive mode when no connection is established yet to 8.8.8.8 (Google):
```
nameserver 172.19.0.2
search mycompany.com
```
* Alternatively, if your system uses `systemd-resolved` for providing name resolution to local applications (check with `systemctl is-active systemd-resolved.service`) create a config/systemd-resolved.template file with the following format:

```
[Resolve]
DNS=172.19.0.2
Domains=mycompany.com ~.
```

* Specify the routes you wish to forward through the VPN in the file config/routes. Only these routes will
be routed via the VPN. For example:
```
routes=(10.0.0.0/8)
```
Additional routes are space separated (it is a normal bash array)
* Optionally add a response file called `config/response.txt`. If present, the commands in this file will be read to work non-interactively. You will also be prompted separately to enter your password, which is then available as `$VPN_PASSWORD` in the response file. For example:
```
connect vpn.mycompany.com
1
vpn-username
$VPN_PASSWORD
y
```

## To run

1. run sudo ./start-vpn
1. type "connect 'your vpn endpoint'"
1. continue with rest of login script 

This project is for informational use only. Do not use to bypass your company procedures or security policies. Use at your own risk. I can offer no support for this project 
