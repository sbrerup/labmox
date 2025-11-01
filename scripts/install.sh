#!/bin/bash

source ../.env

ssh $PROXMOX_USER@$PROXMOX_HOST 'curl -fsSL https://tailscale.com/install.sh | sh'
ssh $PROXMOX_USER@$PROXMOX_HOST 'tailscale up --ssh'
