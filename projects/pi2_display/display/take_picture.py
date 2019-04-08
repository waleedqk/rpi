from picamera import PiCamera
from time import sleep
import os


home = os.environ['HOME']

camera = PiCamera()
camera.start_preview()
sleep(5)
camera.capture(home + '/Pictures/image.jpg')
camera.stop_preview()