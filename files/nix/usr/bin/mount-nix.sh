#!/usr/bin/env bash
# NOTE:
# we only sync when there is no store, no syncing afterwards ever!
# nix/lix from that point on is managed through itself
# the rpm package is only used for population of the initial store

set -euo pipefail

# Bind-mount /var/lib/nix-store to /nix.
# If /var/lib/nix-store is empty, seed it from the baked store in /usr/share/nix-store.

mkdir -p /usr/share/nix-store /var/lib/nix-store /nix

copy_seed_store() {
	if command -v rsync >/dev/null 2>&1; then
		rsync -aH --delete /usr/share/nix-store/ /var/lib/nix-store/
	else
		cp -a /usr/share/nix-store/. /var/lib/nix-store/
	fi
}

ensure_system_profile() {
	local seed_profile="/usr/share/nix-store/var/nix/profiles/system"
	local target_profile="/var/lib/nix-store/var/nix/profiles/system"

	mkdir -p /var/lib/nix-store/var/nix/profiles

	if { [ ! -e "$target_profile" ] || [ -L "$target_profile" ] && [ ! -e "$(readlink -f "$target_profile")" ]; } &&
		{ [ -e "$seed_profile" ] || [ -L "$seed_profile" ]; }; then
		cp -a "$seed_profile" "$target_profile"
	fi
}

if ! mountpoint -q /nix; then
	# ONE-SHOT BOOTSTRAP: Only runs if the persistent store is completely empty
	if [ -z "$(ls -A /var/lib/nix-store 2>/dev/null)" ] && compgen -G "/usr/share/nix-store/*" >/dev/null; then
		copy_seed_store

		ensure_system_profile

		# Run the heavy SELinux relabeling ONLY once in the machine's lifetime
		if command -v restorecon >/dev/null 2>&1; then
			restorecon -RF /var/lib/nix-store || true
		fi
	fi

	# --- Every normal boot handles only these quick lines (~0.001s total) ---

	mount --bind /var/lib/nix-store /nix

	# Force an executable SELinux context on the bind mount so systemd can exec nix-daemon.
	if ! mount -o remount,bind,exec,context=system_u:object_r:bin_t:s0 /nix 2>/dev/null; then
		mount -o remount,bind,exec /nix
	fi

	# Ensure daemon paths exist and labels are sane.
	if command -v systemd-tmpfiles >/dev/null 2>&1; then
		systemd-tmpfiles --create /usr/lib/tmpfiles.d/nix-daemon.conf
	fi

	# Ensure the top-level mount point label is happy (instant check, non-recursive)
	if command -v restorecon >/dev/null 2>&1; then
		restorecon -F /nix || true
	fi
fi
