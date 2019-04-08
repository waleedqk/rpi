#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

now=`date '+%Y_%m_%d__%H_%M_%S'`;
raspistill -o $HOME"/Pictures/image_${now}.jpg"

sudo fbi -T 2 -d /dev/fb1 -noverbose -a $HOME"/Pictures/image.jpg"