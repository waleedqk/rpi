# Camera Basics

**First Shot**

    raspistill -o $HOME"/Pictures/image.jpg"

**View the image**

    gpicview $HOME"/Pictures/image.jpg"

**Delay before taken image**

    raspistill -t 15000 -o $HOME"/Pictures/image.jpg"

**Record 10 sec Video**

    raspivid -t 10000 -o $HOME"/Videos/testvideo.h264"

**Record Video of Dimension**

    raspivid -w 800 -h 480 -t 10000 -o $HOME"/Videos/testvideo.h264"

**Image Effects**

    raspistill -ifx negative -o $HOME"/Pictures/image.jpg"

**Take PNG**

    raspistill -o $HOME"/Pictures/image.png" –e png