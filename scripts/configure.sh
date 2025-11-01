#!/bin/bash

source ../.env

ssh $PROXMOX_USER@$PROXMOX_HOST 'echo "MAGIC_SSH=$(hostname)"' >> ../.env

source ../.env

ssh $PROXMOX_USER@$MAGIC_SSH 'echo executed with magic dns'