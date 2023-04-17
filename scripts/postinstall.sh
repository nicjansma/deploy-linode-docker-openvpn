#!/bin/bash

MV='sudo mv -v'
OVPN_NAME="ovpn"
OVPN_DATA="ovpn-data"

# Update the system
sudo dnf update -y

# Install docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io

# Start docker
sudo service docker start

# Print docker info
sudo docker info

# Install docker-openvpn service
$MV /tmp/docker-openvpn@data.service /etc/systemd/system/docker-openvpn@data.service
sudo restorecon -v /etc/systemd/system/docker-openvpn@data.service

# Configure iptables
sudo modprobe iptable_nat
sudo modprobe iptable_filter

# Restore the volume
sudo docker volume create $OVPN_DATA
gunzip -c /tmp/openvpn-server.tar.gz | sudo docker run -v $OVPN_DATA:/etc/openvpn -i docker.io/kylemanna/openvpn:latest tar -xvf - -C /etc/openvpn

# Start OpenVPN server process
sudo docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN --name $OVPN_NAME docker.io/kylemanna/openvpn:latest

# Enable and start openvpn container as a service
sudo systemctl enable docker-openvpn@data.service
sudo systemctl start docker-openvpn@data.service
