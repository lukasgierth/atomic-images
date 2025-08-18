#!/usr/bin/env bash
sudo $(which dfu-programmer) atmega32u2 erase --force
sudo $(which dfu-programmer) atmega32u2 flash "${1}"
sudo $(which dfu-programmer) atmega32u2 reset
