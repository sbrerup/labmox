#!/bin/bash

vm_id="8000"
vm_name="ubuntu-minimal-template"

storage="local-zfs"
cores="2"
cpu="host"
memory="2048"

scsihw="virtio-scsi-single"
net0="virtio,bridge=vmbr0,firewall=1"
iso_remote_path="https://cloud-images.ubuntu.com/minimal/releases/noble/release/ubuntu-24.04-minimal-cloudimg-amd64.img"
iso_local_path="/tmp/ubuntu-24.04-minimal-cloudimg-amd64.img"

wget -nc -O $iso_local_path $iso_remote_path

qm create "$vm_id" \
    --name "$vm_name" \
    --cores "$cores" \
    --cpu "$cpu" \
    --memory "$memory" \
    --scsihw "$scsihw" \
    --net0 "$net0" \
    --ide2 "$storage:cloudinit" \
    --agent enabled=1

qm disk import $vm_id $iso_local_path $storage
qm set $vm_id --scsi0 $storage:vm-$vm_id-disk-0,discard=on,iothread=on
qm set $vm_id --boot order=scsi0
qm template $vm_id 
