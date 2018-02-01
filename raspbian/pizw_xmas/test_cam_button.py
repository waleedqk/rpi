#!/usr/bin/python3

import picamera
from time import sleep

import time, os, sys

# Get the current time
getthetime = time.strftime("%Y%m%d-%H%M%S")

# create an instance of the PiCamera class
camera = picamera.PiCamera()


# take a picture
image_name = 'image_'+str(getthetime)+'.jpg'
camera.capture(os.environ['HOME'] + '/Pictures/'+image_name)


os.system('sudo fbi -T 2 -d /dev/fb1 -noverbose -a ~/Pictures/'+image_name)