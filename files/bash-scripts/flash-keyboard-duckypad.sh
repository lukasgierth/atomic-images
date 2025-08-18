#!/usr/bin/env bash
# TODO: check for correct file type
sudo $(which dfu-util) --device ,0483:df11 -a 0 -D "${1}"
