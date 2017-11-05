#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

apt-get install apache2 -y
sudo rm /var/www/index.html
sudo raspistill -o /var/www/testimage.jpg
sudo raspistill -w 1920 -h 1080 -o /var/www/testimageFullHD.jpg
sudo raspistill -w 1920 -h 1080 -t 600000 -tl 10000 -o /var/www/frame%04d.jpg &