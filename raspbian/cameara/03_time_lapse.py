from picamera import PiCamera
from time import sleep

camera = PiCamera()
camera.start_preview()
for i in range(5):
 sleep(5)
 camera.capture('/home/odin/Desktop/image%s.jpg' % i)
camera.stop_preview()