#!/usr/bin/env bash

set -euo pipefail

mkdir -p /etc/gnome-initial-setup
cat <<'EOF' >/etc/gnome-initial-setup/vendor.conf
[pages]
# Never show "enable third party repository screen"
skip=software
EOF

echo "Compile dconf db now after possible changes!" && dconf update
