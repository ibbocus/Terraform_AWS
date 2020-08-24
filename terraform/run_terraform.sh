#!/bin/bash


cd terraform

terraform plan
terraform apply -auto-approve

echo "export App_ip=$(terraform output app_ip)" >> ./.bashrc
echo "export DB_ip=$(terraform output db_ip)" >> ./.bashrc
echo "export Bastion_ip=$(terraform output bastion_ip)" >>./.bashrc

source ~/.bashrc
