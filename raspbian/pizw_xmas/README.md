http://www.instructables.com/id/YouTube-Christmas-Ornament/
https://www.adafruit.com/product/1480
https://github.com/IdleHandsProject/tv_ornament

## Setup the Display:

**Enable SPI**

You need to enable SPI on the pi which involves going into the config and turning it on. Enter:

    sudo raspi-config

navigate to "Interfaces" then "SPI" and turn it to "Yes".

Now reboot the pi.

**Enable FBTFT**

You need to edit ```/etc/modules-load.d/fbtft.conf```

    sudo vim /etc/modules-load.d/fbtft.conf

add

    spi-bcm2835 
    fbtft_device

Next edit /etc/modprobe.d/fbtft.conf

    sudo vim /etc/modprobe.d/fbtft.conf

add

    options fbtft_device name=adafruit22a gpio=reset:25,dc:24,led:23 rotate=270 txbuflen=32768 fps=60 speed=80000000

save the file and reboot the pi. The screen should now be setup as ```/dev/fb1```. You will see that in the program

### Setup the Audio:

Adafruit Tutorial
https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp/raspberry-pi-usage

To setup the I2S simply enter this command:

    curl -sS  https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/i2samp.sh | bash

once its installed, reboot. Then run the same command again to test if the speaker is working!

### Install the extra programs

You will need to install a python library PyTube and a program mplayer.

**Install PYTUBE**

    sudo pip3 install pytube

**Install mplayer:**

    sudo apt-get install mplayer

set image

    sudo wget http://adafruit-download.s3.amazonaws.com/adapiluv320x240.jpg
    sudo fbi -T 2 -d /dev/fb1 -noverbose -a adapiluv320x240.jpg

now test to see if your screen is working.

    sudo wget http://adafruit-download.s3.amazonaws.com/bigbuckbunny320p.mp4
    sudo SDL_VIDEODRIVER=fbcon SDL_FBDEV=/dev/fb1 mplayer -vo sdl -framedrop bigbuckbunny320p.mp4

If you see a video playing, congrats! If not, check your wiring and check the code and the FBTFT documentation.
https://github.com/notro/fbtft/wiki#install


## Adafruit

https://learn.adafruit.com/user-space-spi-tft-python-library-ili9341-2-8?view=all

**Install dependencies**

    sudo apt-get update
    sudo apt-get install build-essential python-dev python-smbus python-pip python-imaging python-numpy git
    sudo pip install RPi.GPIO

**Install TFT**

    cd ~
    git clone https://github.com/adafruit/Adafruit_Python_ILI9341.git
    cd Adafruit_Python_ILI9341
    sudo python setup.py install




## The SPI bus is available on the P1 Header:

    Display--------Raspberry Pi
    BL-------------pin 12 (GPIO 18)
    SCK------------pin 23 (GPIO 11)	
    MISO-----------pin 21 (GPIO 9)
    MOSI-----------pin 19 (GPIO 10)
    CS-------------pin 24 (GPIO 8)
    RST------------pin 22 (GPIO 25)
    D/C------------pin 18 (GPIO 24)
    VIN------------pin 17 (3.3v)
    GND------------pin 20 (GND)

## References

https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=197935
https://www.sudomod.com/forum/viewtopic.php?t=2312
https://marcosgildavid.blogspot.ca/2014/02/getting-ili9341-spi-screen-working-on.html