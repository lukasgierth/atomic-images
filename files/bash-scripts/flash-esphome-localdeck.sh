#!/usr/bin/env bash
sudo $(which esptool.py) --chip esp32-c3 -p /dev/ttyACM0 write_flash 0x0 "${1}"
