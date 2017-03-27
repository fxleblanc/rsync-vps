#!/bin/sh
#
# Entrypoint script
#

#Copy the ssh files into .ssh
mkdir .ssh
cp /ssh/* .ssh/
chmod 600 .ssh/id_rsa

# Start the ssh agent
eval `ssh-agent -s`

# Add the keypair
ssh-add .ssh/id_rsa

# Add the cronfile to fxleblanc's cron
sudo crontab -u 1000 cron/sync

# Launch the script once if ONE_SHOT is defined
if [ -z $ONE_SHOT ]; then
    echo "Starting cron"
    sudo crond -f -l 0
else
    echo "Launching the script once"
    ./cron/script
fi

