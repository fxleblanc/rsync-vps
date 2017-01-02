#!/bin/sh
#
# Entrypoint script
#

# Start the ssh agent
eval `ssh-agent -s`

# Add the keypair
ssh-add .ssh/id_rsa

# Add the cronfile to fxleblanc's cron
sudo crontab -u fxleblanc cron/sync

# Launch the script once if ONE_SHOT is defined
if [ -n $ONE_SHOT ]; then
    echo "Launching the script once"
    ./cron/script
else
    echo "Starting cron"
    sudo crond -f -l 0
fi

