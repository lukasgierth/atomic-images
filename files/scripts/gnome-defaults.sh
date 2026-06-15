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
name='Gradia'
command='/usr/bin/flatpak run be.alexandervanhee.gradia --screenshot=INTERACTIVE'
binding='<Ctrl>Print'
EOF

echo "Compile dconf db now after possible changes!" && dconf update
