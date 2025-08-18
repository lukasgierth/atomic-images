#!/usr/bin/env
# TODO: check for correct file extension
sudo $(which dfu-util) --device ,1eaf:0003 -a 2 -R -D "${1}"
