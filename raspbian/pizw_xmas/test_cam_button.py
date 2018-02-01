#!/usr/bin/python3

import picamera
from time import sleep

import time, os, sys
import getpass, socket

# The current user and hostname of the program
cur_user = getpass.getuser()
hostname = socket.gethostname()

# Get the current time
getthetime = time.strftime("%Y%m%d-%H%M%S")

# create an instance of the PiCamera class
camera = picamera.PiCamera()


# take a picture
image_name = 'image_'+str(getthetime)+'.jpg'
camera.capture('/home/'+cur_user+'/Pictures/'+image_name)


camera.close()

os.system('sudo fbi -T 2 -d /dev/fb1 -noverbose -a /home/'+cur_user+'/Pictures/'+image_name)