

# Change Default boot user

    sudo vim /usr/bin/raspi-config

Under that, there's a line where we will replace the "-u pi" with "-u bob", leaving the rest of the line unchanged:

`if id -u pi > /dev/null 2>&1; then`

Next edit the line:

sed /etc/lightdm/lightdm.conf -i -e "s/^#autologin-user=.*/autologin-user=pi/"

By changing `autologin-user=pi` to be `autologin-user=bob`