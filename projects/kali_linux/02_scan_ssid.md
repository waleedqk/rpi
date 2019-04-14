# Scan for Wifi Networks

## Scan

Get all information of wifi AP near us:

    iwlist wlan0 scan

Get only the ESSIS names

    iwlist wlan0 scan | grep "ESSID"