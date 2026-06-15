#!/usr/bin/env bash

failed=0

echo "== Update Flatpak Applications =="
if flatpak update --assumeyes --noninteractive; then
	:
else
	echo "flatpak update failed"
	failed=1
fi

echo "== Update System Image =="
if sudo bootc upgrade; then
	:
else
	echo "bootc upgrade failed"
	failed=1
fi

if ((failed)); then
	echo "Some updates failed" >&2
	exit 1
fi

key=$(gum choose Quit Reboot Poweroff)
if [[ $key == "Quit" ]]; then
	exit 0
elif [[ $key == "Poweroff" ]]; then
	systemctl poweroff
elif [[ $key == "Reboot" ]]; then
	systemctl reboot
fi
