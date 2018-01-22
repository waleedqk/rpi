http://www.instructables.com/id/YouTube-Christmas-Ornament/

## Setup the Display:

**Enable SPI**

You need to enable SPI on the pi which involves going into the config and turning it on. Enter:

    sudo raspi-config

navigate to "Interfaces" then "SPI" and turn it to "Yes".

Now reboot the pi.

**Enable FBTFT**

You need to edit ```/etc/modules-load.d/fbtft.conf```

    sudo echo "spi-bcm2835 fbtft_device" >> /etc/modules-load.d/fbtft.conf

Next edit /etc/modprobe.d/fbtft.conf

    sudo echo "options fbtft_device name=adafruit22a gpio=reset:25,dc:24,led:23 rotate=270 txbuflen=32768 fps=60 speed=80000000" >> /etc/modprobe.d/fbtft.conf
```

save the file and reboot the pi. The screen should now be setup as /dev/fb1. You will see that in the program


## Setup the Audio:

Adafruit Tutorial
https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp/raspberry-pi-usage

To setup the I2S simply enter this command:

    curl -sS  https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/i2samp.sh | bash

once its installed, reboot. Then run the same command again to test if the speaker is working!

### Install the extra programs

You will need to install a python library PyTube and a program mplayer.

**install PYTUBE**

    sudo pip3 install pytube

**install mplayer:**

    sudo apt-get install mplayer

now test to see if your screen is working.

    wget http://fredrik.hubbe.net/plugger/test.mpg
    sudo SDL_VIDEODRIVER=fbcon SDL_FBDEV=/dev/fb1 mplayer -vo sdl -framedrop test.mpg

If you see a video playing, congrats! If not, check your wiring and check the code and the FBTFT documentation.
https://github.com/notro/fbtft/wiki#install