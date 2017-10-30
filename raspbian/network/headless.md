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
    ssid="ENG-404"
    psk="Pakistan123"
    scan_ssid=1
}
```