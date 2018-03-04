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

# Add ssh keys

    ssh-copy-id -i  ~/.ssh/id_rsa.pub pi@192.168.0.29

# First boot

**Search for all Pi's on the network**

    arp -na | grep -i b8:27:eb

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
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get dist-upgrade
    sudo apt-get install rpi-update
    sudo rpi-update

**Add User**

    sudo adduser username
    sudo passwd username
    sudo adduser username sudo
    sudo reboot

**Allow user to run sudo without password**

    sudo visudo
    <username> ALL=(ALL) NOPASSWD: ALL

**Remove pi user**

    sudo deluser pi
    sudo deluser -remove-home pi

**Set User permissions**

    sudo usermod -aG adm,dialout,cdrom,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio $(whoami)

**Make sudo require a password**

    sudo vim /etc/sudoers.d/010_pi-nopasswd

and change the pi entry (or whichever usernames have superuser rights) to

    username ALL=(ALL) PASSWD: ALL

    # allow all members of a specific group to use sudo without a password
    %username ALL=(ALL) NOPASSWD: ALL

**Git clone**

    mkdir -p $HOME/Documents/git
    cd $HOME/Documents/git
    git clone git@github.com:wqkhan/rpi.git
    git clone https://github.com/wqkhan/rpi.git
    cd rpi
    sudo bash raspbian/scripts/install.sh -i

**Enable cron log**

    sudo vim /etc/rsyslog.conf

and uncomment the line

```# cron.*                          /var/log/cron.log```

After that, you need to restart rsyslog via

    /etc/init.d/rsyslog restart

**Change hostname**

    sudo vim /etc/hostname
    sudo vim /etc/hosts
    sudo /etc/init.d/hostname.sh
    sudo reboot
    hostname