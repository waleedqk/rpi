
## Install software

**Update the pi**

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get update && sudo apt-get upgrade -y

**Install the dependencies**

    sudo apt-get install hostapd isc-dhcp-server isc-dhcp-server-ldap
    sudo apt-get install iptables-persistent

## Set up DHCP server

    sudo nano /etc/dhcpcd.conf
    nano /etc/network/interfaces
    nano /etc/hostapd/hostapd.conf
    sudo nano /etc/default/hostapd

# References

https://learn.adafruit.com/setting-up-a-raspberry-pi-as-a-wifi-access-point?view=all