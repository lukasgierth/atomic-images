#!/usr/bin/env bash

sudo $(which cc2538-bsl) -ewv -p /dev/ttyUSB0 --bootloader-sonoff-usb "${@}"
