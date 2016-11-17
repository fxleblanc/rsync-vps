#!/bin/sh
#
# Entrypoint script
#

# Start the ssh agent
eval `ssh-agent -s`

# Add the keypair
ssh-add .ssh/id_rsa

# Start the cron daemon
sudo crond -f -l 0
