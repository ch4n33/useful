#!/bin/bash
# initialize sshd when setting up a new ubuntu server

# install openssh-server without user interaction
DEBIAN_FRONTEND=noninteractive 

sudo apt-get install -y openssh-server
sudo apt-get install -y openssh-server

# start sshd
sudo systemctl start sshd

# register sshd to start on boot
sudo systemctl enable sshd

# show sshd status
sudo systemctl status sshd

# show sshd version
sshd -v
