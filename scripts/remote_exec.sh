#!/bin/bash

source ../.env

ssh $PROXMOX_USER@$MAGIC_SSH "bash -s" < $@