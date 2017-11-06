import RPi.GPIO as GPIO
import time
from picamera import PiCamera
from time import sleep

GPIO.setmode(GPIO.BCM)

camera = PiCamera()

GPIO.setup(16, GPIO.IN, pull_up_down=GPIO.PUD_UP)

while True:
    input_state = GPIO.input(16)
    if input_state == False:
        print('Button Pressed')
        camera.start_preview()
        sleep(5)
        camera.capture('/var/www/html/image.jpg')
        camera.stop_preview()
        time.sleep(0.2)