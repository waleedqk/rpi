

# Display an image via ssh

## 1) Install feh on rasp_pi

    sudo apt-get update; sudo apt-get install feh

## 2) Connect from host to rasp_pi

Notice the capital X!

    ssh -X pi@raspberry.local

## 3) Open the picture

    feh /path/picture.jpg

Note: loading is not superfast, wait patiently.