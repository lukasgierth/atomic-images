#!/usr/bin/env bash
set -euo pipefail

# Bind-mount /var/lib/nix-store to /nix.
# If /var/lib/nix-store is empty, seed it from the baked store in /usr/share/nix-store.

mkdir -p /usr/share/nix-store /var/lib/nix-store /nix

copy_seed_store() {
	echo "$(date --iso-8601=seconds)  Enter $FUNCNAME"
	if command -v rsync >/dev/null 2>&1; then
		rsync -aH --delete /usr/share/nix-store/ /var/lib/nix-store/
	else
		cp -a /usr/share/nix-store/. /var/lib/nix-store/
	fi
	echo "$(date --iso-8601=seconds)  Exit $FUNCNAME"
}

sync_missing_store() {
	echo "$(date --iso-8601=seconds)  Enter $FUNCNAME"
	# Ensure any baked store paths exist in /var without clobbering user additions.
	if command -v rsync >/dev/null 2>&1; then
		rsync -aH --ignore-existing /usr/share/nix-store/store/ /var/lib/nix-store/store/
	fi
	echo "$(date --iso-8601=seconds)  Exit $FUNCNAME"
}

ensure_system_profile() {
	echo "$(date --iso-8601=seconds)  Enter $FUNCNAME"
	local seed_profile="/usr/share/nix-store/var/nix/profiles/system"
	local target_profile="/var/lib/nix-store/var/nix/profiles/system"

	mkdir -p /var/lib/nix-store/var/nix/profiles

	if { [ ! -e "$target_profile" ] || [ -L "$target_profile" ] && [ ! -e "$(readlink -f "$target_profile")" ]; } &&
		{ [ -e "$seed_profile" ] || [ -L "$seed_profile" ]; }; then
		cp -a "$seed_profile" "$target_profile"
	fi
	echo "$(date --iso-8601=seconds)  Exit $FUNCNAME"
}

if ! mountpoint -q /nix; then
	if [ -z "$(ls -A /var/lib/nix-store 2>/dev/null)" ] && compgen -G "/usr/share/nix-store/*" >/dev/null; then
		copy_seed_store
	fi

	ensure_system_profile
	sync_missing_store

	echo "$(date --iso-8601=seconds)  Try mount --bind"
	mount --bind /var/lib/nix-store /nix
	echo "$(date --iso-8601=seconds)  mount --bind done..."
	# Force an executable SELinux context on the bind mount so systemd can exec nix-daemon.
	# Use a permissive fallback if the label option is rejected.
	if ! mount -o remount,bind,exec,context=system_u:object_r:bin_t:s0 /nix 2>/dev/null; then
		echo "$(date --iso-8601=seconds)  Remount"
		mount -o remount,bind,exec /nix
		echo "$(date --iso-8601=seconds)  Remount done..."
	fi

	# Ensure daemon paths exist and labels are sane.
	if command -v systemd-tmpfiles >/dev/null 2>&1; then
		systemd-tmpfiles --create /usr/lib/tmpfiles.d/nix-daemon.conf
	fi
	if command -v restorecon >/dev/null 2>&1; then
		restorecon -RF /var/lib/nix-store /nix || true
	fi
fi
