#!/bin/bash

sudo apt update -y
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
sudo apt install python -y
sudo apt install python-pip -y
sudo pip install --upgrade pip -y
sudo pip install boto


cd /etc/ansible
echo "[web]
34.250.102.251 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
echo  "[db]
34.243.99.221 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
echo  "[aws]
192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts

