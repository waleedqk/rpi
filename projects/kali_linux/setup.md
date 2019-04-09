# HEADLESS KALI-LINUX SETUP

## Enable ssh on bootup

After flashing the SD card with the image update the ```/YOUR_MOUNT_POINT/etc/crontab``` file to add:

    * *   * * *   root    dpkg-reconfigure openssh-server

Cron is going to execute the command "dpkg-reconfigure openssh-server" every minute. This command will create the missing host keys. Then after 1 minute has passed after boot can ssh into the pi:

    ssh root@IP.ADD.RE.SS

As you have logged in via ssh don't forget to edit ```/etc/crontab``` again and to remove the line containing "dpkg-reconfigure openssh-server" previously added.

    vim /etc/crontab

## Expand the Installation

    resize2fs /dev/mmcblk0p2

## Update the Image

    apt-get update
    apt-get upgrade
    apt-get dist-upgrade

## Update the Date-Time zone

    dpkg-reconfigure tzdata

## Update the root password

    passwd root


## Install OpenSSH Server

    cd /etc/ssh/
    apt-get install openssh-server

Remove the old keys

    update-rc.d -f ssh remove
    update-rc.d -f ssh defaults

Move old keys to backup folder
    mkdir insecure_old
    mv ssh_host* insecure_old

Generate new keys
    dpkg-reconfigure openssh-server

### Enable SSH service to start at boot

    nano /etc/ssh/sshd_config

The line ```PermitRootLogin yes``` should be untabbed and uncommented

Restart the service

    sudo service ssh restart

Enable SSH at boot with the settings

    update-rc.d -f ssh enable 2 3 4 5

Check the status of the service

    sudo service ssh status

Start the service if not running

    sudo service ssh start

## Install VNC and Copy-Paste

    sudo apt install xfce4 xfce4-goodies

    apt-get install tightvncserver autocutsel

Set the VNC password using

    vncpasswd

Run the vncserver

    tightvncserver

Kill a vncserver instance

    vncserver -kill :1

### Configure Auto TightVNC Server startup on the Kali Pi

    cd /etc/init.d
    vim /etc/init.d/vncboot

Insert the script below into the blank document

```
#!/bin/sh
### BEGIN INIT INFO
# Provides: vncboot
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start VNC Server at boot time
# Description: Start VNC Server at boot time.
### END INIT INFO

USER=root
HOME=/root

export USER HOME

case "$1" in
start)
echo "Starting VNC Server"
#Insert your favoured settings for a VNC session
/usr/bin/vncserver :0 -geometry 1280x800 -depth 16 -pixelformat rgb565
;;

stop)
echo "Stopping VNC Server"
/usr/bin/vncserver -kill :0
;;

*)
echo "Usage: /etc/init.d/vncboot {start|stop}"
exit 1
;;
esac

exit 0
```

Change the file perminssions

    chmod 755 /etc/init.d/vncboot

add the dependencies to it by typing

    update-rc.d vncboot defaults

## Enable Autologin

To enable autologin in re4son-kernel, type the following into your terminal window.

    cd /usr/local/src/re4son-kernel_4*
    ./re4son-pi-tft-setup -a root

OR in regular RPi-kali

    nano /etc/lightdm/lightdm.conf

You need to edit these two lines so that they read:

    autologin-user=root
    autologin-user-timeout=0

Then

    nano /etc/pam.d/lightdm-autologin

We need to hash out or comment out that line by editing it to look like this:

    #auth required pam_succeed_if.so user != root quiet_success

    sudo reboot

## INSTALLING FULL VERSION OF KALI LINUX

To install the full version of Kali Linux you need to type this into the terminal:

    apt-get install kali-linux-full

## Enable Bluetooth

To enable Bluetooth, we can use the handy Bluetoothctl built into our Re4son Kali. 

    bluetoothctl

to turn on the Bluetooth agent, type

    agent on

When the agent is registered, type default agent to register the ```default agent``` and enable the Bluetooth controller.

    default agent

To start a scan for Bluetooth devices, and you should see a list of devices begin to populate if there are any Bluetooth devices nearby

    scan on

to pair with any devices you see, type pair and then the MAC address of the device you see on the list.

    pair MC:AD:DR:ES:SS

## Create a Custom MOTD

    nano /etc/motd

Delete the contents and paste whatever you want to show up each time you log in.

## References

Download the Kernel
https://re4son-kernel.com/re4son-pi-kernel/

Video Tutorial
https://www.youtube.com/watch?v=5ExWmpFnAnE

Written Tutorial
https://null-byte.wonderhowto.com/how-to/set-up-headless-raspberry-pi-hacking-platform-running-kali-linux-0176182/
https://null-byte.wonderhowto.com/how-to/build-beginner-hacking-kit-with-raspberry-pi-3-model-b-0184144/

Headless SSH post
https://raspberrypi.stackexchange.com/questions/60606/cant-ssh-in-kali-headless-setup-on-raspberry-pi3

VNC
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04
https://null-byte.wonderhowto.com/how-to/use-vnc-remotely-access-your-raspberry-pi-from-other-devices-0178997/
http://blog.sevagas.com/?VNC-to-access-Kali-Linux-on-Raspberry-Pi

Auto Login
https://dephace.com/raspberry-pi-3-kali-linux-auto-login/