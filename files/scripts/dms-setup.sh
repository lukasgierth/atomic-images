#!/usr/bin/env bash

set -euo pipefail

[ ! -f /etc/environment ] && touch /etc/environment
echo "QT_QPA_PLATFORMTHEME=qt6ct" >>/etc/environment

# Create necessary dir
mkdir -p /etc/xdg/quickshell

# Configure greeter
mkdir -p /etc/greetd
cat <<'EOF' >/etc/greetd/config.toml
[general]
service = "greetd-spawn"

[terminal]
vt = 1

[default_session]
command = "dms-greeter --command niri"
user = "greeter"
EOF

mkdir -p /usr/share/greetd
cat <<'EOF' >/usr/share/greetd/greetd-spawn.pam_env.conf
XDG_SESSION_TYPE DEFAULT=wayland OVERRIDE=wayland
EOF

# Configure pam for greeter/logind session
mkdir -p /usr/lib/pam.d
cat <<'EOF' >/usr/lib/pam.d/greetd-spawn
auth       include      greetd
auth       required     pam_env.so conffile=/usr/share/greetd/greetd-spawn.pam_env.conf
account    include      greetd
session    include      greetd
EOF

# Setting up stuff to temporarily enable sudo without password for all wheel users, needed for dms greeter sync
mkdir -p /etc/sudoers.d
cat <<'EOF' >/etc/sudoers.d/wheel-script
%wheel ALL=(ALL) NOPASSWD: /usr/bin/wheel-allow-all enable, /usr/bin/wheel-allow-all disable
EOF

mkdir -p /usr/bin
cat <<'EOF' >/usr/bin/wheel-allow-all
#!/usr/bin/env bash

case "$1" in
	enable)
		echo "Enable NOPASSWD for wheel"
		echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/tmp-wheel-allow-all
		;;
	disable)
		echo "Disable NOPASSWD for wheel"
		rm -f /etc/sudoers.d/tmp-wheel-allow-all
		;;
	*)
		echo "not valid"
		exit 1
		;;
esac
EOF
chmod 755 /usr/bin/wheel-allow-all
