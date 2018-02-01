#!/usr/bin/python3

import time
import RPi.GPIO as GPIO

gpio_pin=26 # The GPIO pin the button is attached to
longpress_threshold=5 # If button is held this length of time, tells system to leave light on

GPIO.setmode(GPIO.BCM)
GPIO.setup(gpio_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

while True:
    time.sleep(0.2)

    if GPIO.input(gpio_pin) == False: # Listen for the press, the loop until it steps
        print "Started press"
        pressed_time=time.time()
        while GPIO.input(gpio_pin) == False:
            time.sleep(0.2)

        pressed_time=time.time()-pressed_time
        print ("Button pressed for: {}"format(pressed_time))
        if pressed_time<longpress_threshold:
            print("Below threshold")
        else:
            print("Above threshold")
