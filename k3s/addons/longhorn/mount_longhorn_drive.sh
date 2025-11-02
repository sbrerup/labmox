#!/bin/bash

set -ex

DISK_PATH="/dev/sdc"
MOUNT_PATH="/var/lib/longhorn"

echo "Starting Longhorn disk setup for $DISK_PATH..."

mkdir -p $MOUNT_PATH

if ! blkid -o value -s TYPE $DISK_PATH; then
  echo "Disk $DISK_PATH is not formatted. Formatting with ext4..."
  mkfs.ext4 $DISK_PATH
fi

UUID=$(blkid -s UUID -o value $DISK_PATH)

if ! grep -q "UUID=$UUID" /etc/fstab; then
  echo "Adding UUID=$UUID to /etc/fstab..."
  FSTAB_ENTRY="UUID=$UUID  $MOUNT_PATH  ext4  defaults,nofail  0  2"
  echo $FSTAB_ENTRY | tee -a /etc/fstab
fi

mount -a

echo "Disk $DISK_PATH successfully mounted to $MOUNT_PATH."