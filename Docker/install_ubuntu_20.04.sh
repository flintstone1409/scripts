#!/bin/sh

# info

# normal update and install tools (on most distributions pre installed)
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y htop nano wget curl tmux

# uninstall old versions
sudo apt remove docker docker-engine docker.io containerd runc

# install using repo
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# add docker key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# add repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo adduser $(whoami) docker

echo ''
echo ''
echo '--- After relogging you should be able to use docker without sudo ---'
echo ''
echo ''
