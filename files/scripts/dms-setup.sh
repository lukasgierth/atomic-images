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

# Greeter setup system service
mkdir -p /usr/lib/systemd/system
cat <<'EOF' >/usr/lib/systemd/system/setup-greeter.service
[Unit]
Description=Set up greeter for dms
ConditionPathExists=!/etc/setup-greeter
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -c "getent group greeter &> /dev/null || useradd -M -U greeter; for user in $(getent passwd | grep 'home' | awk -F: '{print $1}'); do usermod -aG greeter $user; done"
ExecStart=/usr/bin/mkdir -p /var/cache/dms-greeter
ExecStart=/usr/bin/chown -R greeter:greeter /var/cache/dms-greeter
ExecStart=/usr/bin/systemctl set-default graphical.target
ExecStart=/usr/bin/touch /etc/setup-greeter
ExecStart=/usr/bin/systemctl restart greetd.service

[Install]
WantedBy=multi-user.target
EOF

# Greeter sync user service
mkdir -p /usr/lib/systemd/user
cat <<'EOF' >/usr/lib/systemd/user/sync-greeter.service
[Unit]
Description=Sync greeter visuals
ConditionPathExists=/etc/setup-greeter
ConditionPathExists=/usr/bin/wheel-allow-all

[Service]
Type=oneshot
StandardOutput=journal
ExecStart=/usr/bin/sudo /usr/bin/wheel-allow-all enable
ExecStart=/usr/bin/dms greeter sync
ExecStart=/usr/bin/sudo /usr/bin/wheel-allow-all disable

[Install]
WantedBy=default.target
EOF
