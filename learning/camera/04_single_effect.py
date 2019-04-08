from picamera import PiCamera
from time import sleep

camera = PiCamera()
camera.start_preview()
camera.image_effect = 'colorswap'
sleep(5)
camera.capture('/home/odin/Pictures/colorswap.jpg')
camera.stop_preview()