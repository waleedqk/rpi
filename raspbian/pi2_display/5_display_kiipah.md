# 5" Display Kippah Portable Raspberry Pi

**Guide from**

    https://learn.adafruit.com/portable-kippah-pi?view=all

for the display

    https://www.adafruit.com/product/1680

5.0" 40-pin 800x480 TFT Display without Touchscreen

**Update & Upgrade**

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install rpi-update
    sudo rpi-update
    sudo reboot

**Install and Try raspi-gpio**

    sudo apt-get install raspi-gpio
    sudo raspi-gpio get

**Install Device Tree Blob**

    cd ~
    wget https://raw.githubusercontent.com/adafruit/Adafruit-DPI-Kippah/master/dt-blob.bin
    sudo cp dt-blob.bin /boot/

**Update configuration**

    sudo vim /boot/config.txt

and add the following lines at the bottom

### Disable spi and i2c, we need these pins.
dtparam=spi=off
dtparam=i2c_arm=off

### Set screen size and any overscan required
overscan_left=0
overscan_right=0
overscan_top=0
overscan_bottom=0
framebuffer_width=800
framebuffer_height=480

### enable the DPI display
enable_dpi_lcd=1
display_default_lcd=1

### set up the size to 800x480
dpi_group=2
dpi_mode=87

### set up the hsync/vsync/clock polarity and format
dpi_output_format=454661

### set up the size to 800x480
hdmi_timings=800 0 40 48 88 480 0 13 3 32 0 0 0 60 0 32000000 6

**Change Display setting**

This sets up the screen, if you ever want to temporarily 'undo the DPI Hat install' just delete these lines under: `sudo vim /boot/config.txt`

    enable_dpi_lcd=1
    display_default_lcd=1

