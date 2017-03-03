
# list devices
sudo fdisk -l

# start command line of gparted
sudo parted /dev/mmcblk0
# set appropriate units
unit chs
# list all partitions
print
# exit parted
quit

# umount the sd card
umount /dev/sdb1
umount /dev/sdb2

# format to FAT32 partition
sudo mkdosfs -F 32 -I /dev/sdb

# dd the image to the card
dd bs=4M if=~/path/to/raspbian-image.img of=/dev/sdb
sudo sync
