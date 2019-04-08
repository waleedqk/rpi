import sys, os, time, datetime
from picamera import PiCamera
from time import sleep

# path to directory of python file
dirname, filename = os.path.split(os.path.abspath(__file__))
dir_path = os.path.dirname(os.path.realpath(__file__))
parent_dir = os.path.dirname(os.getcwd())

basedir = os.environ["HOME"]+"/Pictures/"


camera = PiCamera()
camera.start_preview()

for i in range(5):
    sleep(2)
    datetime_now = datetime.datetime.now().strftime("%Y_%m_%d__%H-%M-%S")
    image = "{}image_{}_{}.jpg".format(basedir, str(i).zfill(2), datetime_now)
    
    camera.capture(image)
camera.stop_preview()