#!/bin/bash

# Check if the script is running as root, otherwise prompt for sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#Make sure we're up to date and reinstall using Docker's current documentation
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  apt-get remove -y $pkg
done

apt-get update

# Necessary libraries for Docker/Nvidia GPU to communicate
apt-get install -y nvidia-container-toolkit nvidia-container-runtime nvidia-docker2

#OpenGL packages - not all necessary probably but I thought we'd cover a lot of the bases just in case
apt-get install -y mesa-utils libglvnd-dev libglfw3 libglfw3-dev freeglut3 freeglut3-dev

# Set up Docker's apt repo
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Install Docker Engine/Daemon/CLI
apt-get install -y docker-ce docker-ce-cli containerd.io

usermod -aG docker $USER

apt-get install -y docker-compose

#PLEASE LOGOUT ༼;´༎ຶ ۝ ༎ຶ༽
echo "please logout before pulling and running the docker image. Pls, seriously it will just take a second. You're probably going to have a bad time if you don't."
