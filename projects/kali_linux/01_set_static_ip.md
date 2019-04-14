# Set Static IP

## Check current creddentials

Record the IP for reference

    ip addr

Get the IP address of the router:

    route -n

## Set ethernet static IP

    vim /etc/network/interfaces

add the following after the relevant interface e.g. eth0:

```
auto eth0
#iface eth0 inet dhcp
iface eth0 inet static
    address 192.168.0.9
    netmask 255.255.255.0
    broadcast 255.255.255.0
    gateway 192.168.0.1
```

then reboot

    sudo reboot now

Identify interface type

    lsusb
    ethtool -i wlan0 | grep driver
    ethtool -i wlan1 | grep driver

## Set WiFi credentials for use

    vim /etc/network/interfaces

```
auto wlan0
iface wlan0 inet dhcp
    wpa-ssid "ENG404"
    wpa-psk "Pakistan123"
```


## Automatically connect to WiFi when near

Update the file:

    cd /etc/wpa_supplicant/
    
edit the file ```wpa_supplicant.conf``` with the appropriate network credentials:

    vim /etc/wpa_supplicant/wpa_supplicant.conf

```
network={
ssid="ENG404"
psk="Pakistan123"
scan_ssid=1
}
```

Then update the interface file for the wlan0 connection:

    vim /etc/network/interfaces

```
auto wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
```