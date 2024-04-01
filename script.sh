#!/bin/bash

sudo apt-get update -y
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo usermod -a -G docker ubuntu
newgrp docker

sudo docker run talshaham/maven-app:3
