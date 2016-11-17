# Rsync vps

# Goal
This image is mainly intended to sync a remote folder in designated volume. However, this image is somewhat flexible so feel free to experiment.

# Usage

## Prerequisites
In order for the image to build, you will need a few files that you need to put in the apptly named secret folder. This folder is not tracked by git as it will contain sensitive information

### An ssh keypair
The user will access the remote location using these keys. So, you need to have the remote already setup to accept the public key. Here is the structure:
```
secret/id_rsa
secret/id_rsa.pub
```

### An ssh config
This is mainly to avoid being bothered by the yes/no question when accessing a remote location for the first time. The file will named like config and must be in the secret directory
```
secret/config
```
As for the contents of the file, it could look like this:
```
Host remote
     StrictHostKeyChecking no
     IdentityFile ~/.ssh/id_rsa
```

### A cron file
This file is, you guessed it, used by the cron daemon to execute your task. Here is the structure
```
secret/cronfile
```
And for the contents, here is an example
```
* * * * * /usr/bin/rsync remote://path/to/folder /var/data
```

#### See also
https://askubuntu.com/questions/123072/ssh-automatically-accept-keys

## Building the container
This is a no-brainer. You just build the image using
```
docker build -t rsync-vps:latest .
```

## Running the container

### Volume mapping
In this image, the host volume should be mapped to /var/data. As an example:
```
docker run -d -v /tmp/test:/var/data rsync-vps:latest
```

# Troubleshooting

## Bad owner or permissions on .ssh/config
Assuming you are in the cloned repository directory, run:
```
chmod 600 secret/config
```

### See also
https://serverfault.com/questions/253313/ssh-hostname-returns-bad-owner-or-permissions-on-ssh-config