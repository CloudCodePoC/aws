#!/bin/bash
# brand new ubuntu instance on aws
# 2017-11-08
# P Campbell
#
# new instance setup part 1
# Install software
#
# software to install for using VNC server
# GUI on remote via a VNC client
# 

sudo apt-get install --no-install-recommends lubuntu-desktop
sudo apt-get install vnc4server expect -y
