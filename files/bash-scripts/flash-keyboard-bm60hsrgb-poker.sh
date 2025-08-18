#!/usr/bin/env bash
sudo $(which dfu-programmer) atmega32u4 erase --force
sudo $(which dfu-programmer) atmega32u4 flash "${1}"
sudo $(which dfu-programmer) atmega32u4 reset
