import sys, os, time, datetime

# path to directory of python file
dirname, filename = os.path.split(os.path.abspath(__file__))
dir_path = os.path.dirname(os.path.realpath(__file__))
parent_dir = os.path.dirname(os.getcwd())

basedir = os.environ["HOME"]+"/Pictures/"

from picamera import PiCamera
from time import sleep

camera = PiCamera()
camera.start_preview()
sleep(5)

datetime_now = datetime.datetime.now().strftime("%Y_%m_%d__%H-%M-%S")
image = "{}image_{}.jpg".format(basedir, datetime_now)

camera.capture(image)
camera.stop_preview()