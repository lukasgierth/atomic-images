#!/usr/bin/env bash

set -euo pipefail

mkdir -p /etc/gnome-initial-setup
cat <<'EOF' >/etc/gnome-initial-setup/vendor.conf
[pages]
# Never show "enable third party repository screen"
skip=software
EOF

mkdir -p /etc/dconf/db/distro.d

cat <<'EOF' >/etc/dconf/db/distro.d/01-custom-keybindings
[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0]
name='Open Alacritty'
command='alacritty'
binding='<Super>t'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1]
name='Open Files'
command='nautilus'
binding='<Super>f'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2]
name='Use screenshotter with gradia'
command='flatpak run be.alexandervanhee.gradia --screenshot=INTERACTIVE'
binding='Print'
EOF

echo "Compile dconf db now after possible changes!" && dconf update
