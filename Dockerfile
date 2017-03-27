FROM alpine:3.4
MAINTAINER fxleblanc

# Add the 1000 user
RUN adduser 1000 -D

# Install rsync
RUN apk add --no-cache rsync

# Install ssh
RUN apk add --no-cache openssh-client

# Transfer entrypoint script
ADD entry.sh /usr/bin/entry

# Change ownership make it executable
RUN chown 1000:1000 /usr/bin/entry

# Install sudo
RUN apk add --no-cache sudo

# Add 1000 as sudo
RUN echo '1000 ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to user 1000
USER 1000

# Change working directory
WORKDIR /home/1000

# Entrypoint script
ENTRYPOINT ["/usr/bin/entry"]
