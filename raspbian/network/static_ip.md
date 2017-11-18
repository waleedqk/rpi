# Static local IP address

**Get current Connection Info**

    sudo ifconfig

Write down the "inet addr" (Pi's current IP), the "bcast" (the broadcast IP range), and the "mask" (subnet mask address)

    netstat -nr

Write down the "destination" and the "gateway/network."

Should have something like this:

```
net address 192.168.1.115
bcast 192.168.1.255
mask 255.255.255.0
gateway 192.168.1.1
network 192.168.1.1
destination 192.168.1.0
```

**set a static internal IP**

    sudo vim /etc/dhcpcd.conf

append this to the bottom of the file

```
interface eth0
static ip_address=192.168.1.115
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```

    sudo reboot

**Port forwarding**

https://www.youtube.com/watch?v=iskxw6T1Wb8

**Static IP**

    ip -4 addr show | grep global

    ip route | grep default | awk '{print $3}'

    cat /etc/resolv.conf


    vim /etc/dhcpcd.conf

```
#profile static_wlan0
interface wlan0
static ip_address=192.168.0.201/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
```