#!/bin/bash

source ../.env

ssh $PROXMOX_USER@$MAGIC_SSH 'pvesm add dir local-tf --path /terraform --content iso,import,snippets'
echo 'local_tf_storage = "local-tf"' >> ../terraform/terraform.tfvars