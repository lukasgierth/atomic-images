#!/usr/bin/env bash
# TODO: check for hex
sudo $(which dfu-programmer) atmega32u4 erase --force
sudo $(which dfu-programmer) atmega32u4 flash "${1}"
sudo $(which dfu-programmer) atmega32u4 reset
