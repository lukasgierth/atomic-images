#!/usr/bin/env bash
FW="${1}"
NAME=$(lsblk -P -p -d --output NAME,MODEL | grep "DFU[ _]Disk" | awk '{print $1}' | awk -F'"' '$0=$2')
# FIX: test if NAME empty before continue
sudo umount "${NAME}"
sudo mkdir /tmp/mntdfu
sudo mount -t msdos "${NAME}" /tmp/mntdfu
BASENAME=$(basename $FW | tr a-z A-Z)
sudo cp "${FW}" "/tmp/mntdfu/${BASENAME}" && sync
sudo umount /tmp/mntdfu
sudo rmdir /tmp/mntdfu
