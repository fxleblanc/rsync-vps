FROM alpine:3.4
MAINTAINER fxleblanc

# Add the fxleblanc user
RUN adduser fxleblanc -D

# Install rsync
RUN apk add --no-cache rsync

# Install ssh
RUN apk add --no-cache openssh-client

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
