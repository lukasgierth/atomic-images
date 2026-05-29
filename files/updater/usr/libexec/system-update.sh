#!/usr/bin/env bash

failed=0

echo "== Update Fisher =="
if fish -c "if type -q fisher; if string length --quiet (fisher list); fisher update >/dev/null; end; end"; then
	:
else
	echo "fisher update failed"
	failed=1
fi

if command -v mise >/dev/null; then
	echo "== Update Mise Tools =="
	if mise upgrade; then
		:
	else
		echo "mise upgrade failed"
		failed=1
	fi
fi

if command -v krewfile >/dev/null; then
	echo "== Update Krewfile =="
	if krewfile -upgrade; then
		:
	else
		echo "krewfile -upgrade failed"
		failed=1
	fi
elif command -v krew >/dev/null; then
	echo "== Update Krew Tools =="
	if krew upgrade; then
		:
	else
		echo "krew upgrade failed"
		failed=1
	fi
fi

if command -v home-manager >/dev/null; then
	if [ -d ~/.config/home-manager ]; then
		echo "== Home-Manager Tools =="
		(cd ~/.config/home-manager && nix flake update && home-manager switch)
	else
		echo "home-manager: ~/.config/home-manager not found, skipping"
	fi
fi

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
