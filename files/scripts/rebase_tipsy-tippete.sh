#!/usr/bin/env bash

set -euo pipefail

# Bash Shell
cat <<'EOF' >/usr/lib/systemd/system/signed-autorebase.service
[Unit]
Description=Autorebase to signed OCI and reboot
ConditionPathExists=!/etc/signed-autorebase
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
StandardOutput=journal
ExecStart=/usr/bin/rpm-ostree rebase --bypass-driver ostree-image-signed:docker://ghcr.io/lukasgierth/tipsy-tippete:latest
ExecStart=/usr/bin/touch /etc/signed-autorebase
ExecStart=/usr/bin/systemctl reboot

[Install]
WantedBy=multi-user.target
EOF
