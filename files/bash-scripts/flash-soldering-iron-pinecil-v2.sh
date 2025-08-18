#!/usr/bin/env bash
# INFO: Needs blisp tool; Get into flashing mode by pressing "-" before connecting USB, keep pressed for 15 more seconds
if [[ "${1}" =~ ".bin" ]]; then
	sudo $(which blisp) write -c bl70x --reset "${1}"
else
	echo -e "Error, only .bin files allowed!"
fi
