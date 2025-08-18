#!/usr/bin/env bash
# INFO: Needs dfu-util tool; Get into flashing mode by pressing "-" before connecting USB, keep pressed for 15 more seconds
if [[ "${1}" =~ ".dfu" ]]; then
	sudo $(which dfu-util) -D "${1}"
else
	echo -e "Error, only .dfu files allowed!"
fi
