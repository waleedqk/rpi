# Take image cron job

Run crontab with the -e flag to edit the cron table:

    crontab -e

and add this to run this every minute

    * * * * * sudo python /home/odin/Documents/git/rpi/raspbian/camera/server/picture_server.py