### 2.4" display with 320x240 16-bit color pixels

### Guide from
https://learn.adafruit.com/adafruit-2-4-pitft-hat-with-resistive-touchscreen-mini-kit?view=all

This design uses the hardware SPI pins (SCK, MOSI, MISO, CE0, CE1) as well as GPIO #25 and #24.

### Step 1. Expand Filesystem
sudo raspi-config

### Step 2. Install new Kernel
curl -SLs https://apt.adafruit.com/add-pin | sudo bash
sudo apt-get install raspberrypi-bootloader adafruit-pitft-helper raspberrypi-kernel

### Step 3. Enable & Configure the PiTFT
sudo adafruit-pitft-helper -t 28r



### How can I force the Pi to bring up X on the HDMI/TV monitor?
There's two ways to do it. In older Pi installs, use the fb0 framebuffer when you want to display stuff on the HDMI/TV display, for example:
## FRAMEBUFFER=/dev/fb0 startx
will use the HDMI/TV framebuffer for X windows instead of the PiTFT

On Jessie Pi installs, run
## sudo nano /usr/share/X11/xorg.conf.d/99-fbdev.conf
to edit the configuration file and make sure it contains:
'''
Section "Device"
  Identifier "display"
  Driver "fbdev"
  Option "fbdev" "/dev/fb0"
EndSection
'''
## change the Option "fbdev" "/dev/fb0" line to Option "fbdev" "/dev/fb1" if you want the xdisplay on the PiTFT


### Test Video (using mplayer)
mkdir -p /home/pi/Videos/bunny
cd /home/pi/Videos/bunny
wget http://adafruit-download.s3.amazonaws.com/bigbuckbunny320p.mp4
sudo SDL_VIDEODRIVER=fbcon SDL_FBDEV=/dev/fb1 mplayer -vo sdl -framedrop bigbuckbunny320p.mp4