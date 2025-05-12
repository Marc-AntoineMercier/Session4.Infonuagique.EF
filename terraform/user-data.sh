#!/bin/bash

echo "Updating packages..."
sudo apt update
echo "Installing dependencies..."
sudo apt install -y git curl

echo "Installing Docker using convenience script..."
sudo curl -fsSL https://get.docker.com -o /opt/get-docker.sh
sudo sh /opt/get-docker.sh

echo "Cloning the repo..."
sudo git clone https://github.com/Marc-AntoineMercier/Session4.Infonuagique.Ef /opt/ep_final 

echo "Deploying application..."
sudo docker compose -f /opt/ep_final/compose.yaml up -d

echo "Waiting for database to populate..."
sleep 30

sudo rm -rf /opt/*

