#!/bin/bash

sudo wget -q -O - https://tjend.github.io/repo_terraform/repo_terraform.key | sudo apt-key add -
sudo echo 'deb [arch=amd64] https://tjend.github.io/repo_terraform stable main' >> /etc/apt/sources.list.d/terraform.list
sudo apt-get update
sudo apt-get install terraform

cd terraform/
terraform init
