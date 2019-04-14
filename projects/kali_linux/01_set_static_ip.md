# Set Static IP

## Check current creddentials

    ifconfig

Record the IP for reference

## Update

    vim /etc/network/interfaces

add the following after the relevant interface e.g. eth0:

```
auto eth0
#iface eth0 inet dhcp
iface eth0 inet static
address 192.168.0.9
network 192.168.0.0
netmask 255.255.255.0
```

then reboot

    sudo reboot now