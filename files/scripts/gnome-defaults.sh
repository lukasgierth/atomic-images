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
binding='<Super><Shift>t'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1]
name='Open Default Terminal'
command='ptyxis'
binding='<Super>t'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2]
name='Open Firefox'
command='flatpak run org.mozilla.firefox'
binding='<Super>b'

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3]
name='Open Files'
command='nautilus'
binding='<Super>f'
EOF
echo "Compile dconf db now after changes!" && dconf update
