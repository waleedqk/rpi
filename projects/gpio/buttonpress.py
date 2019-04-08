import RPi.GPIO as GPIO
import time

bt = 5

GPIO.setmode(GPIO.BCM)

GPIO.setup(bt, GPIO.IN, pull_up_down=GPIO.PUD_UP)

while True:
    input_state = GPIO.input(bt)
    if input_state == False:
        print('Button Pressed')
        time.sleep(0.2)
