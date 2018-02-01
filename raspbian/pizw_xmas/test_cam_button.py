#!/usr/bin/python3

import picamera
from time import sleep

import time, os, sys
import getpass, socket

import RPi.GPIO as GPIO


GPIO.setmode(GPIO.BCM)
CAM_PIN = 26
GPIO.setup(CAM_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# The current user and hostname of the program
cur_user = getpass.getuser()
hostname = socket.gethostname()

# create an instance of the PiCamera class
camera = picamera.PiCamera()

def take_pic(*args,**kwargs):
    # Get the current time
    getthetime = time.strftime("%Y%m%d-%H%M%S")

    # take a picture
    image_name = 'image_'+str(getthetime)+'.jpg'
    camera.capture('/home/'+cur_user+'/Pictures/'+image_name)

    os.system('sudo fbi -T 2 -d /dev/fb1 -noverbose -a /home/'+cur_user+'/Pictures/'+image_name)



if __name__ == "__main__":

    while True:
        input_state = GPIO.input(CAM_PIN)
        if input_state == False:
            print('Button Pressed')
            time.sleep(0.2)

    camera.close()