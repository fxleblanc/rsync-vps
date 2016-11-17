FROM alpine:3.4
MAINTAINER fxleblanc

# Add the fxleblanc user
RUN adduser fxleblanc -D

# Transfer ssh keys
RUN mkdir /home/fxleblanc/.ssh/
ADD secret/id_rsa /home/fxleblanc/.ssh/id_rsa
ADD secret/id_rsa.pub /home/fxleblanc/.ssh/id_rsa.pub
ADD secret/config /home/fxleblanc/.ssh/config
ADD secret/cronfile /etc/cronfile

# Change the ownership of the .ssh directory to fxleblanc
RUN chown -R fxleblanc:fxleblanc /home/fxleblanc/.ssh

# Configure external volume
RUN mkdir /var/data
RUN chown fxleblanc:fxleblanc /var/data
VOLUME ["/var/data"]

# Install rsync
RUN apk add --no-cache rsync

# Install ssh
RUN apk add --no-cache openssh-client

# Configure crontab to use the transfered file
RUN crontab -u fxleblanc /etc/cronfile

# Transfer entrypoint script
ADD entry.sh /usr/bin/entry

# Change ownership make it executable
RUN chown fxleblanc:fxleblanc /usr/bin/entry

# Install sudo
RUN apk add --no-cache sudo

# Add fxleblanc as sudo
RUN echo 'fxleblanc ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to user fxleblanc
USER fxleblanc

# Change working directory
WORKDIR /home/fxleblanc

# Entrypoint script
ENTRYPOINT ["/usr/bin/entry"]
