#!/usr/bin/env bash
set -euo pipefail

echo "WARNING: This script will:"
echo "  1. Stop the nix-daemon.service"
echo "  2. DELETE everything in /nix/"
echo "  3. Reboot this system"
echo ""
echo "This is IRREVERSIBLE and will reset your Nix installation."
echo ""

if [ "$(id -u)" -eq 0 ]; then
	echo "Error: Do not run this script as root. It uses sudo for specific commands."
	exit 1
fi

if ! command -v gum &>/dev/null; then
	echo "Error: gum is not installed"
	exit 1
fi

if ! systemctl is-active --quiet nix-daemon.service 2>/dev/null; then
	echo "Error: nix-daemon.service is not running"
	exit 1
fi

if [ ! -d /nix ] || [ -z "$(ls -A /nix 2>/dev/null)" ]; then
	echo "Error: /nix is empty or does not exist, nothing to delete"
	exit 1
fi

echo "Files that will be deleted:"
ls -la /nix/
echo ""

if gum confirm "Are you absolutely sure you want to delete everything in /nix/ and reboot?"; then
	echo "Stopping nix-daemon..."
	sudo systemctl stop nix-daemon.service

	echo "Deleting /nix/ contents..."
	sudo rm -rf /nix/*

	echo "Syncing filesystems..."
	sync

	echo "Rebooting..."
	systemctl reboot
fi
