# First boot

**SSH into the pi**

    ssh pi@raspberrypi.local

**Expand Filesystem**

    raspi-config

**Update the pi**

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get dist-upgrade

**Add User**

    sudo addduser username
    sudo passwd username
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

    git clone https://github.com/wqkhan/rpi.git