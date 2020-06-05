## About
This project enables a linux host to run Cisco Anyconnect and Traps/Cortex in a docker container. The wrapper
script then routes selected network ranges to the VPN. Currently all DNS traffic is sent through the VPN

## To configure

All configuration is performed in the config/ directory

* Create a client directory structure that contains your public and private keys:
```
+config/client
+-- <User ID>.pem
+--private
|  +-- <User ID>.key 
|
```

These should be the same as the originally created keys for openconnect.

* Obtain the AnyConnect linux installer program. Place in the file 'packages/anyconnect.tar.gz'
* Obtain the "Traps/Cortex" debian linux installer. Place in the file 'packages/cortex.deb' directory. 
* Create a config/resolv.template file containing the VPN's DNS configuration, for example:
```
domain mycompany.com
nameserver 10.20.30.40
nameserver 10.20.31.40
search mycompany.com
```
* Specify the routes you wish to forward through the VPN in the file config/routes. Only these routes will
be routed via the VPN. For example:
```
routes=(10.0.0.0/8)
```
Additional routes are space separated (it is a normal bash array)

## To run

1. run sudo ./start-vpn
1. type "connect 'your vpn endpoint'"
1. continue with rest of login script 

This project is for informational use only. Do not use to bypass your company procedures or security policies. Use at your own risk. I can offer no support for this project 
