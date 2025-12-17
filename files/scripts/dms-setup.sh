#!/usr/bin/env bash

set -euo pipefail

[ ! -f /etc/environment ] && touch /etc/environment
echo "QT_QPA_PLATFORMTHEME=qt6ct" >>/etc/environment

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
