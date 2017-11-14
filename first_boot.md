# Headless Networking


**Enable ssh**

navigate to the boot folder in the SD card

    touch ssh

**WiFi Credentials**

navigate to the boot folder in the SD card

    vim wpa_supplicant.conf

add the following lines of code

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
ssid="ENG404"
psk="Pakistan123"
scan_ssid=1
}
```

# First boot

**SSH DNS Spoofing**

    ssh-keygen -f "/home/wqkhan/.ssh/known_hosts" -R 192.168.0.27
    ssh-keygen -f "/home/wqkhan/.ssh/known_hosts" -R raspberrypi.local

**SSH into the pi**

    ssh pi@raspberrypi.local

**Expand Filesystem**

    sudo raspi-config

**List all users**

    cut -d: -f1 /etc/passwd

**Update the pi**

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get dist-upgrade
    sudo apt-get install rpi-update
    sudo rpi-update

**Add User**

    sudo adduser username
    sudo passwd username
    sudo adduser username sudo
    sudo reboot
    sudo visudo
    sudo deluser pi
    sudo deluser -remove-home pi

**Make sudo require a password**

    sudo vim /etc/sudoers.d/010_pi-nopasswd

and change the pi entry (or whichever usernames have superuser rights) to

    pi ALL=(ALL) PASSWD: ALL

**Change hostname**

    sudo vim /etc/hostname
    sudo vim /etc/hosts
    sudo /etc/init.d/hostname.sh
    sudo reboot
    hostname

**Git clone**

    mkdir -p $HOME/Documents/git
    cd $HOME/Documents/git
    git clone https://github.com/wqkhan/rpi.git
    cd rpi/raspbian
    sudo bash scripts/install.sh all