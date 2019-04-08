#!/usr/bin/python3

import picamera
from time import sleep

import time, os, sys

# create an instance of the PiCamera class
camera = picamera.PiCamera()


# Get the current time
getthetime = time.strftime("%Y%m%d-%H%M%S")

# with the raspistill command, you can apply a horizontal and vertical flip 
# camera.hflip = True
# camera.vflip = True

# take a picture
camera.capture('~/Pictures/image.jpg')

# Preview the camera feed on screen
camera.start_preview()
for i in range(100):
    camera.brightness = i
    sleep(0.2)
    
sleep(5)

# use the stop_preview method to remove the preview overlay and restore the display
camera.stop_preview()

# change other camera configuration
# camera.brightness = 70  # (values between 0 and 100) - default 50
# camera.sharpness = 0
# camera.contrast = 0
# camera.saturation = 0
# camera.ISO = 0
# camera.video_stabilization = False
# camera.exposure_compensation = 0
# camera.exposure_mode = 'auto'
# camera.meter_mode = 'average'
# camera.awb_mode = 'auto'
# camera.image_effect = 'none'
# camera.color_effects = None
# camera.rotation = 0
# camera.hflip = False
# camera.vflip = False
# camera.crop = (0.0, 0.0, 1.0, 1.0)


# VIDEO RECORDING
# camera.start_recording('video.h264')
# sleep(5)
# camera.stop_recording()

camera.close()